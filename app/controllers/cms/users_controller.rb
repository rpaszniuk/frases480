class CMS::UsersController < ApplicationController
  include CMSAccessControl
  before_action :permissions_and_breadcrumbs

  def index
    @users = User.active.includes(:access_profile)
    @users = @users.where('email LIKE :k OR first_name LIKE :k OR last_name LIKE :k', k: "%#{params[:k]}%") unless params[:k].blank?
    @users = @users.order(id: :desc).paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'El nuevo Usuario ha sido creado.'
      redirect_to edit_cms_user_path(@user)
    else
      flash[:error] = error_summary_message(@user)
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'El Usuario ha sido actualizado.'
      redirect_to edit_cms_user_path(@user)
    else
      flash[:error] = error_summary_message(@user)
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.deleted?
      if user.can_be_destroyed?
        if user.destroy
          flash[:success] = 'El Usuario ha sido destruido.'
          redirect_to :cms_users
        else
          flash[:error] = 'No pudimos destruir el registro, contactar con Rodrigo Paszniuk.'
          redirect_to edit_cms_user_path(user)
        end
      else
        flash[:error] = 'No pudimos destruir el registro por que posee otros registros dependientes.'
        redirect_to edit_cms_user_path(user)
      end
    else
      user.mark_as_deleted?
      flash[:success] = 'El Usuario ha sido marcado como borrado.'
      redirect_to edit_cms_user_path(user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :access_profile_id, :avatar, :status, :broker_id, :storm_id)
  end

  def permissions_and_breadcrumbs
    if @current_user.access_profile.can?(:full_access, :users)
      case params[:action]
      when 'index'
        @breadcrumbs << { label: t('breadcrumbs.users.main') }
      when 'new', 'create'
        @breadcrumbs << { label: t('breadcrumbs.users.main'), url: cms_users_path }
        @breadcrumbs << { label: t('breadcrumbs.users.new') }
      when 'edit', 'update'
        @breadcrumbs << { label: t('breadcrumbs.users.main'), url: cms_users_path }
        @breadcrumbs << { label: t('breadcrumbs.users.edit') }
      end
    else
      flash[:error] = t('alerts.cms.access_denied')
      redirect_to :cms_dashboard
    end
  end
end
