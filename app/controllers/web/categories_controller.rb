class WEB::CategoriesController < ApplicationController
  include WEBAccessControl
  before_action :set_category, only: [:show]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.order(:name)
    respond_to do |format|
      format.html { redirect_to web_root_path }
      format.json {}
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @page_title = @category.title
    @phrases = @category.phrases.active.paginate(page: params[:page], per_page: 15)
    @phrases_count = @category.phrases.active.count
  end

  private

  def set_category
    id_or_slug = params[:id]
    if id_or_slug.to_i != 0
      @category = Category.find(id_or_slug)
    else
      @category = Category.find_by!(slug: id_or_slug)
    end
  end
end
