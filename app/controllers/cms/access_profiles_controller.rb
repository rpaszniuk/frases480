class CMS::AccessProfilesController < ApplicationController
  include CMSAccessControl
  before_action :permissions_and_breadcrumbs

  def index
    @access_profiles = AccessProfile.active
    @access_profiles = @access_profiles.where('name LIKE :k', k: "%#{params[:k]}%") unless params[:k].blank?
    @access_profiles = @access_profiles.paginate(page: params[:page])
  end

  def new
    @access_profile = AccessProfile.new
  end

  def create
    @access_profile = AccessProfile.new(access_profile_params)
    if @access_profile.save
      flash[:success] = 'The new Access Profile was created.'
      redirect_to edit_access_profile_path(@access_profile)
    else
      flash[:error] = error_summary_message(@access_profile)
      render :new
    end
  end

  def edit
    @access_profile = AccessProfile.find(params[:id])
  end

  def update
    @access_profile = AccessProfile.active.find(params[:id])
    if @access_profile.update_attributes(access_profile_params)
      flash[:success] = 'The Access Profile was updated.'
      redirect_to edit_access_profile_path(@access_profile)
    else
      flash[:error] = error_summary_message(@access_profile)
      render :edit
    end
  end

  def destroy
    access_profile = AccessProfile.find(params[:id])
    if access_profile.deleted?
      if access_profile.can_be_destroyed?
        if access_profile.destroy
          flash[:success] = 'The new Access Profile was created.'
          redirect_to :access_profiles
        else
          flash[:error] = "We couldn't delete the record, please contact 10 Grounds."
          redirect_to edit_access_profile_path(access_profile)
        end
      else
        flash[:error] = "The record can't be destroyed, there are other records that depend on it."
        redirect_to edit_access_profile_path(access_profile)
      end
    else
      access_profile.mark_as_deleted?
      flash[:success] = 'The Access Profile was marked as deleted.'
      redirect_to edit_access_profile_path(access_profile)
    end
  end

  private

  def access_profile_params
    params.require(:access_profile).permit(:name, :status, permissions:
      [
        users: [:full_access],
        access_profiles: [:full_access]
      ])
  end

  def permissions_and_breadcrumbs
    if @current_user.access_profile.can?(:full_access, :access_profiles)
      case params[:action]
      when 'index'
        @breadcrumbs << { label: t('breadcrumbs.access_profiles.main') }
      when 'new', 'create'
        @breadcrumbs << { label: t('breadcrumbs.access_profiles.main'), url: access_profiles_path }
        @breadcrumbs << { label: t('breadcrumbs.access_profiles.new') }
      when 'edit', 'update'
        @breadcrumbs << { label: t('breadcrumbs.access_profiles.main'), url: access_profiles_path }
        @breadcrumbs << { label: t('breadcrumbs.access_profiles.edit') }
      end
    else
      flash[:error] = t('alerts.cms.access_denied')
      redirect_to :dashboard
    end
  end
end
