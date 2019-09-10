class CMS::UsersController < ApplicationController
  include CMSAccessControl
  before_action :permissions_and_breadcrumbs

  def index
    @users = User.active.includes(:access_profile)
    @users = @users.where('email LIKE :k OR first_name LIKE :k OR last_name LIKE :k', k: "%#{params[:k]}%") unless params[:k].blank?
    @users = @users.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'The new User was created.'
      redirect_to edit_user_path(@user)
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
      flash[:success] = 'The User was updated.'
      redirect_to edit_user_path(@user)
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
          flash[:success] = 'The User was destroyed.'
          redirect_to :users
        else
          flash[:error] = "We couldn't delete the record, please contact 10 Grounds."
          redirect_to edit_user_path(user)
        end
      else
        flash[:error] = "The record can't be destroyed, there are other records that depend on it."
        redirect_to edit_user_path(user)
      end
    else
      user.mark_as_deleted?
      flash[:success] = 'The User was marked as deleted.'
      redirect_to edit_user_path(user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :access_profile_id, :status)
  end

  def permissions_and_breadcrumbs
    if @current_user.access_profile.can?(:full_access, :users)
      case params[:action]
      when 'index'
        @breadcrumbs << { label: t('breadcrumbs.users.main') }
      when 'new', 'create'
        @breadcrumbs << { label: t('breadcrumbs.users.main'), url: users_path }
        @breadcrumbs << { label: t('breadcrumbs.users.new') }
      when 'edit', 'update'
        @breadcrumbs << { label: t('breadcrumbs.users.main'), url: users_path }
        @breadcrumbs << { label: t('breadcrumbs.users.edit') }
      end
    else
      flash[:error] = t('alerts.cms.access_denied')
      redirect_to :dashboard
    end
  end
end
