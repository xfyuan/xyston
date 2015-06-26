class UserSerializer < ActiveModel::Serializer
  embed :ids
  attributes :id, :name, :email, :firstname, :lastname, :admin, :created_at, :updated_at
  has_many :products
end
