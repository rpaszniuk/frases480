class API::V1::Me::PhrasesController < ApplicationController
  include APIAccessControl
  before_action :is_authenticated?

  def index
    per_page = 20
    page = (params[:page] || 1).to_i

    phrases = @request_user.phrases.order(created_at: :desc)
    phrases = phrases.where('phrase LIKE :k', k: "%#{params[:q]}%")
    phrases = phrases.paginate(page: page, per_page: per_page)

    render json: phrases, each_serializer: API::V1::PhraseSerializer, status: :ok, root: 'data', adapter: :json, meta: {
      total: phrases.total_entries,
      per_page: per_page,
      next: phrases.next_page ? api_v1_me_phrases_path(page: phrases.next_page) : nil,
      previous: phrases.previous_page ? api_v1_me_phrases_path(page: phrases.previous_page) : nil,
      next_page: phrases.next_page,
      previous_page: phrases.previous_page
    }
  end

  def show
    phrase = @request_user.phrases.find(params[:id])
    render json: phrase, serializer: API::V1::PhraseSerializer, status: :ok
  end

  def create
    phrase = Phrase.new(phrase_params)
    phrase.user_id = @request_user.id
    if phrase.save
      render json: phrase, serializer: API::V1::PhraseSerializer, status: :ok
    else
      render json: { errors: phrase.errors }, status: :unprocessable_entity
    end
  end

  def update
    phrase = @request_user.phrases.find(params[:id])
    if phrase.update(phrase_params)
      render json: phrase, serializer: API::V1::PhraseSerializer, status: :ok
    else
      render json: { errors: phrase.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    phrase = @request_user.phrases.find(params[:id])
    if phrase.deleted?
      if phrase.can_be_destroyed?
        if phrase.destroy
          render nothing: true, status: :no_content
        else
          render json: { errors: 'No pudimos destruir el registro, contactar con Frases 480.' }, status: :unprocessable_entity
        end
      else
        render json: { errors: 'No pudimos destruir el registro por que posee otros registros dependientes.' }, status: :unprocessable_entity
      end
    else
      phrase.mark_as_deleted?
      render nothing: true, status: :no_content
    end
  end

  private

  def phrase_params
    params.permit(:phrase, :category_id)
  end
end
