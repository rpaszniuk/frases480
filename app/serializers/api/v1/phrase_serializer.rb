class API::V1::PhraseSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :phrase, :slug, :category, :url, :status

  def url
    web_show_phrase_url(object.category.slug, object.slug) if object.category
  end

  def category
    API::V1::CategorySimpleSerializer.new(object.category) if object.category
  end
end
