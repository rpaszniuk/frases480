class API::V1::CategoriesController < ApplicationController
  include APIAccessControl

  def index
    cache_engine = CacheEngine.new
    categories = cache_engine.web_categories
    render json: categories, each_serializer: API::V1::CategorySerializer, root: 'data', adapter: :json, status: :ok
  end

  def show
    per_page = 20
    page = (params[:page] || 1).to_i

    category = Category.find(params[:id])
    if params[:q].blank?
      cache_engine = CacheEngine.new
      phrases = cache_engine.web_category_phrases(category, page)
    else
      phrases = Phrase.active
      phrases = phrases.where('phrase LIKE :k', k: "%#{params[:q]}%")
      phrases = phrases.order(id: :desc).paginate(page: page, per_page: per_page)
    end

    render json: phrases, each_serializer: API::V1::PhraseSimpleSerializer, status: :ok, root: 'data', adapter: :json, meta: {
      category: API::V1::CategorySerializer.new(category),
      total: phrases.total_entries,
      per_page: per_page,
      next: phrases.next_page ? api_v1_category_path(page: phrases.next_page) : nil,
      previous: phrases.previous_page ? api_v1_category_path(page: phrases.previous_page) : nil,
      next_page: phrases.next_page,
      previous_page: phrases.previous_page
    }
  end
end
