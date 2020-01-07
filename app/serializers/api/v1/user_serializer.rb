class API::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :time_zone, :status
end
