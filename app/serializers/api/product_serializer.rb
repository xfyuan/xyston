class Api::ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :published
end
