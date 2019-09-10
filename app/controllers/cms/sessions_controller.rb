class CMS::SessionsController < ApplicationController
  def login
    @user_auth = UserAuth.new(user_auth_params)
    if @user_auth.login_successful?
      session[:sess_user] = @user_auth.user.id
      redirect_to :cms_dashboard
    else
      render 'cms/login/index', layout: 'cms_empty'
    end
  end

  def logout
    reset_session
    session[:sess_user] = nil
    flash[:notice] = t('alerts.logout')
    redirect_to :cms_root
  end

  protected

  def user_auth_params
    params.require(:user_auth).permit(:email, :password)
  end
end
