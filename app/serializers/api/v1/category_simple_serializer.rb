class API::V1::CategorySimpleSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug
end
