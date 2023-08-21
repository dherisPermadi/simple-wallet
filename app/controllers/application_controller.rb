class ApplicationController < ActionController::API
  include SerializerGenerator

  def current_user
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
