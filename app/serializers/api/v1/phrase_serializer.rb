class API::V1::PhraseSerializer < ActiveModel::Serializer
  attributes :id, :phrase, :slug, :category_id, :status
end
