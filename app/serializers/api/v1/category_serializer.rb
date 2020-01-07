class API::V1::CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :slug, :status
end
