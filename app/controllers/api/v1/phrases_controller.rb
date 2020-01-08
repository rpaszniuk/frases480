class API::V1::PhrasesController < ApplicationController
  include APIAccessControl
  before_action :is_authenticated?

  def index
    per_page = 20
    page = (params[:page] || 1).to_i

    if params[:q].blank?
      cache_engine = CacheEngine.new
      phrases = cache_engine.web_phrases(page)
    else
      phrases = Phrase.active
      phrases = phrases.where('phrase LIKE :k', k: "%#{params[:q]}%")
      phrases = phrases.order(id: :desc).paginate(page: page, per_page: per_page)
    end

    render json: phrases, each_serializer: API::V1::PhraseSerializer, status: :ok, root: 'data', adapter: :json, meta: {
      total: phrases.total_entries,
      per_page: per_page,
      next: phrases.next_page ? api_v1_phrases_path(page: phrases.next_page) : nil,
      previous: phrases.previous_page ? api_v1_phrases_path(page: phrases.previous_page) : nil,
      next_page: phrases.next_page,
      previous_page: phrases.previous_page
    }
  end

  def show
    phrase = Phrase.find(params[:id])
    render json: phrase, serializer: API::V1::PhraseSerializer, status: :ok
  end

  private

  def phrase_params
    params.permit(:phrase, :category_id)
  end
end
