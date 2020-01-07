class API::V1::UsersController < ApplicationController
  include APIAccessControl

  def create
    user = User.new(user_sign_up_params)
    if user.save
      render json: { token: user.auth_token, user: API::V1::UserSerializer.new(user) }, status: :ok
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def sign_in
    user_auth = UserAuth.new(user_sign_in_params)
    if user_auth.do_sign_in
      render json: { token: user_auth.user.auth_token, user: API::V1::UserSerializer.new(user_auth.user) }, status: :ok
    else
      render json: { errors: user_auth.errors }, status: :unprocessable_entity
    end
  end

  def recover_password
    user_auth = UserAuth.new(user_sign_in_params)
    user_auth.signing_in = false
    if user_auth.do_recover_password
      render nothing: true, status: :ok
    else
      render json: { errors: user_auth.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_sign_in_params
    params.permit(:email, :password)
  end

  def user_sign_up_params
    params.permit(:first_name, :last_name, :email, :password, :time_zone)
  end
end
