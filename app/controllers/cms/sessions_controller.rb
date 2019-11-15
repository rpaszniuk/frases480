class CMS::SessionsController < ApplicationController
  layout 'cms_empty'

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
    flash[:notice] = t('alerts.cms.logout')
    redirect_to :cms_root
  end

  def sign_up
    unless session[:sess_user].nil?
      redirect_to :cms_dashboard
      return
    end
    @user = User.new
    return if request.get?

    @user = User.new(user_params)
    @user.access_profile_id = 3
    @user.validate
    if !params['g-recaptcha-response'].blank? && @user.save
      flash[:success] = 'Te has registrado satisfactoriamente'
      session[:sess_user] = @user.id
      redirect_to :cms_dashboard
    else
      flash[:error] = 'Debe completar correctamente los campos y la verificación captcha'
      render :sign_up
    end
  end

  def forgot_password
    unless session[:sess_user].nil?
      redirect_to :cms_dashboard
      return
    end
    @user_auth = UserAuth.new
    return if request.get?

    @user_auth = UserAuth.new(user_auth_params)
    @user_auth.signing_in = false
    if @user_auth.do_recover_password?
      flash[:success] = 'Te hemos enviado un email con las instrucciones'
      redirect_to :cms_root
    else
      flash[:error] = 'Hubo un problema al intentar recuperar tu contraseña'
      render :forgot_password
    end
  end

  protected

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :avatar)
  end

  def user_auth_params
    params.require(:user_auth).permit(:email, :password)
  end
end
