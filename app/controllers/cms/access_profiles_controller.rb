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
      flash[:success] = 'El nuevo Perfil de Acceso ha sido creado'
      redirect_to edit_cms_access_profile_path(@access_profile)
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
      flash[:success] = 'El Perfil de Acceso ha sido actualizado.'
      redirect_to edit_cms_access_profile_path(@access_profile)
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
          flash[:success] = 'El Perfil de Acceso ha sido destruido.'
          redirect_to :cms_access_profiles
        else
          flash[:error] = 'No pudimos destruir el registro, contactar con 10 Rodrigo Paszniuk.'
          redirect_to edit_cms_access_profile_path(access_profile)
        end
      else
        flash[:error] = 'No pudimos destruir el registro por que posee otros registros dependientes.'
        redirect_to edit_cms_access_profile_path(access_profile)
      end
    else
      access_profile.mark_as_deleted?
      flash[:success] = 'El Perfil de Acceso ha sido marcado como borrado.'
      redirect_to edit_cms_access_profile_path(access_profile)
    end
  end

  private

  def access_profile_params
    params.require(:access_profile).permit(:name, :status, permissions:
      [
        users: [:full_access],
        access_profiles: [:full_access],
        phrases: [:full_access],
        categories: [:full_access]
      ])
  end

  def permissions_and_breadcrumbs
    if @current_user.access_profile.can?(:full_access, :access_profiles)
      case params[:action]
      when 'index'
        @breadcrumbs << { label: t('breadcrumbs.access_profiles.main') }
      when 'new', 'create'
        @breadcrumbs << { label: t('breadcrumbs.access_profiles.main'), url: cms_access_profiles_path }
        @breadcrumbs << { label: t('breadcrumbs.access_profiles.new') }
      when 'edit', 'update'
        @breadcrumbs << { label: t('breadcrumbs.access_profiles.main'), url: cms_access_profiles_path }
        @breadcrumbs << { label: t('breadcrumbs.access_profiles.edit') }
      end
    else
      flash[:error] = t('alerts.cms.access_denied')
      redirect_to :cms_dashboard
    end
  end
end
