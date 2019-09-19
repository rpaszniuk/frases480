class WEB::MainController < ApplicationController
  include WEBAccessControl

  def index
    @cache_engine = CacheEngine.new
    @categories = @cache_engine.web_categories
    @phrases = Phrase.active.order(id: :desc).includes(:category).paginate(page: params[:page], per_page: 15)
  end

  def about
    @page_title = 'Acerca de'
  end

  def sitemap
    @cache_engine = CacheEngine.new
    @categories = @cache_engine.web_categories
    @phrases = Phrase.active.order(id: :desc).includes(:category)
    render template: 'web/main/sitemap.xml.builder', layout: false
  end

  def feed
    @cache_engine = CacheEngine.new
    @phrases = @cache_engine.web_last_phrases
    render template: 'web/main/feed.rss.builder', layout: false
  end
end
