class RegistrationSerializer < ActiveModel::Serializer
  attributes :token

  def token
    object.access_tokens.last.token
  end
end
