class API::V1::CategoriesController < ApplicationController
  include APIAccessControl
  before_action :is_authenticated?

  def index
    categories = Category.active.order(:name)
    render json: categories, each_serializer: API::V1::CategorySerializer, root: 'data', adapter: :json, status: :ok
  end

  def show
    category = Category.find(params[:id])
    render json: category, serializer: API::V1::CategorySerializer, status: :ok
  end
end
