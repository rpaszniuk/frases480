class WEB::MainController < ApplicationController
  include WEBAccessControl

  def index
    @categories = Category.active.order(:slug)
    @phrases = Phrase.active.order(id: :desc).includes(:category).paginate(page: params[:page], per_page: 15)
  end

  def about
    @page_title = 'Acerca de'
  end

  def sitemap
    @phrases = Phrase.active.includes(:category)
    @categories = Category.active
    render template: 'web/main/sitemap.xml.builder', layout: false
  end

  def feed
    @phrases = Phrase.active.includes(:category).order(id: :desc).limit(15)
    render template: 'web/main/feed.rss.builder', layout: false
  end
end
