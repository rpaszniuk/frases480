class API::V1::PhraseSerializer < ActiveModel::Serializer
  attributes :id, :phrase, :slug, :category, :status

  def category
    API::V1::CategorySimpleSerializer.new(object.category) if object.category
  end
end
