class CMS::PhrasesController < ApplicationController
  include CMSAccessControl
  before_action :permissions_and_breadcrumbs

  def index
    @phrases = Phrase.includes(:category, :user)
    @phrases = @phrases.where(user_id: @current_user.id) unless @current_user.access_profile.can?(:full_access, :phrases)
    @phrases = @phrases.where('phrase LIKE :k', k: "%#{params[:k]}%") unless params[:k].blank?
    @phrases = @phrases.where(category_id: params[:category_id]) unless params[:category_id].blank?
    @phrases = @phrases.where(status: params[:status]) unless params[:status].blank?
    @phrases = @phrases.order(id: :desc).paginate(page: params[:page])
  end

  def new
    @phrase = Phrase.new
  end

  def create
    @phrase = Phrase.new(phrase_params)
    @phrase.user = @current_user
    @phrase.status = :pending unless @current_user.access_profile.can?(:full_access, :phrases)
    if @phrase.save
      flash[:success] = 'La nueva frase ha sido creada.'
      redirect_to edit_cms_phrase_path(@phrase)
    else
      flash[:error] = error_summary_message(@phrase)
      render :new
    end
  end

  def edit
    @phrase = @current_user.access_profile.can?(:full_access, :phrases) ? Phrase.find(params[:id]) : @current_user.phrases.find(params[:id])
  end

  def update
    @phrase = @current_user.access_profile.can?(:full_access, :phrases) ? Phrase.find(params[:id]) : @current_user.phrases.find(params[:id])
    if @phrase.update_attributes(phrase_params)
      flash[:success] = 'La frase ha sido actualizada.'
      redirect_to edit_cms_phrase_path(@phrase)
    else
      flash[:error] = error_summary_message(@phrase)
      render :edit
    end
  end

  def destroy
    phrase = @current_user.access_profile.can?(:full_access, :phrases) ? Phrase.find(params[:id]) : @current_user.phrases.find(params[:id])
    if phrase.deleted?
      if phrase.can_be_destroyed?
        if phrase.destroy
          flash[:success] = 'La frase ha sido destruida.'
          redirect_to :cms_phrases
        else
          flash[:error] = 'No pudimos destruir el registro, contactar con Frases 480.'
          redirect_to edit_cms_phrase_path(phrase)
        end
      else
        flash[:error] = 'No pudimos destruir el registro por que posee otros registros dependientes.'
        redirect_to edit_cms_phrase_path(phrase)
      end
    else
      phrase.mark_as_deleted?
      flash[:success] = 'La frase ha sido marcada como borrado.'
      redirect_to edit_cms_phrase_path(phrase)
    end
  end

  private

  def phrase_params
    params.require(:phrase).permit(:phrase, :slug, :status, :user_id, :category_id)
  end

  def permissions_and_breadcrumbs
    case params[:action]
    when 'index'
      @breadcrumbs << { label: t('breadcrumbs.phrases.main') }
    when 'new', 'create'
      @breadcrumbs << { label: t('breadcrumbs.phrases.main'), url: cms_phrases_path }
      @breadcrumbs << { label: t('breadcrumbs.phrases.new') }
    when 'edit', 'update'
      @breadcrumbs << { label: t('breadcrumbs.phrases.main'), url: cms_phrases_path }
      @breadcrumbs << { label: t('breadcrumbs.phrases.edit') }
    end
  end
end
