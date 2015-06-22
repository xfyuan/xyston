class Api::SessionSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :token

  def token
    object.authentication_token
  end
end
