class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :password, :authentication_token, :firstname, :lastname, :admin
end
