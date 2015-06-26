class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :firstname, :lastname, :admin, :created_at, :updated_at
end
