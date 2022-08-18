class WEB::PhrasesController < ApplicationController
  include WEBAccessControl
  before_action :set_phrase, only: [:show]

  # GET /phrases
  # GET /phrases.json
  def index
    @cache_engine = CacheEngine.new
    @phrases = @cache_engine.web_phrases(params[:page])
    @phrases_count = @cache_engine.web_phrases_count
    respond_to do |format|
      format.html { redirect_to web_root_path }
      format.json {}
    end
  end

  # GET /phrases/1
  # GET /phrases/1.json
  def show
    return render file: "#{Rails.root}/public/404.html", status: 404, layout: false unless @phrase

    @page_title = @phrase.title
  end

  private

  def set_phrase
    id_or_slug = params[:phrase].blank? ? params[:id] : params[:phrase]
    if id_or_slug.to_i != 0
      @phrase = Phrase.includes(:category).find(id_or_slug)
      redirect_to web_show_phrase_path(@phrase.category.slug, @phrase.slug), status: 301
    else
      @phrase = Phrase.includes(:category).find_by(slug: id_or_slug)
    end
  end
end
