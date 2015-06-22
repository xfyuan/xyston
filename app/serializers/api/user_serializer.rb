class Api::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :firstname, :lastname, :admin
end
