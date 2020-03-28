class API::V1::PhraseSimpleSerializer < ActiveModel::Serializer
  attributes :id, :phrase, :slug, :status
end
