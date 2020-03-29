class API::V1::PhraseSimpleSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :phrase, :slug, :url, :status

  def url
    web_show_phrase_url(object.category.slug, object.slug) if object.category
  end
end
