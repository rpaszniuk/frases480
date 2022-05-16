class API::V1::MeController < ApplicationController
  include APIAccessControl
  before_action :is_authenticated?

  def show
    render json: @request_user, serializer: API::V1::UserSerializer, status: :ok
  end

  def update
    if @request_user.update(user_params)
      render json: @request_user, serializer: API::V1::UserSerializer, status: :ok
    else
      render json: { errors: @request_user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :time_zone, :password)
  end
end
