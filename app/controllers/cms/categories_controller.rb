class CMS::CategoriesController < ApplicationController
  include CMSAccessControl
  before_action :permissions_and_breadcrumbs

  def index
    @categories = Category.all
    @categories = @categories.where('name LIKE :k', k: "%#{params[:k]}%") unless params[:k].blank?
    @categories = @categories.order(id: :desc).paginate(page: params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'La categoría ha sido creada.'
      redirect_to edit_cms_category_path(@category)
    else
      flash[:error] = error_summary_message(@category)
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = 'La categoría ha sido actualizada.'
      redirect_to edit_cms_category_path(@category)
    else
      flash[:error] = error_summary_message(@category)
      render :edit
    end
  end

  def destroy
    category = Category.find(params[:id])
    if category.deleted?
      if category.can_be_destroyed?
        if category.destroy
          flash[:success] = 'La categoría ha sido destruida.'
          redirect_to :cms_categories
        else
          flash[:error] = 'No pudimos destruir el registro, contactar con Rodrigo Paszniuk.'
          redirect_to edit_cms_category_path(category)
        end
      else
        flash[:error] = 'No pudimos destruir el registro por que posee otros registros dependientes.'
        redirect_to edit_cms_category_path(category)
      end
    else
      category.mark_as_deleted?
      flash[:success] = 'La categoría ha sido marcada como borrado.'
      redirect_to edit_cms_category_path(category)
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :description, :slug, :status)
  end

  def permissions_and_breadcrumbs
    if @current_user.access_profile.can?(:full_access, :categories)
      case params[:action]
      when 'index'
        @breadcrumbs << { label: t('breadcrumbs.categories.main') }
      when 'new', 'create'
        @breadcrumbs << { label: t('breadcrumbs.categories.main'), url: cms_categories_path }
        @breadcrumbs << { label: t('breadcrumbs.categories.new') }
      when 'edit', 'update'
        @breadcrumbs << { label: t('breadcrumbs.categories.main'), url: cms_categories_path }
        @breadcrumbs << { label: t('breadcrumbs.categories.edit') }
      end
    else
      flash[:error] = t('alerts.cms.access_denied')
      redirect_to :cms_dashboard
    end
  end
end
