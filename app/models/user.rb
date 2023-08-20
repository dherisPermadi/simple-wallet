class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :access_grants, class_name: 'Doorkeeper::AccessGrant',
                           foreign_key: :resource_owner_id,
                           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens, class_name: 'Doorkeeper::AccessToken',
                           foreign_key: :resource_owner_id,
                           dependent: :delete_all # or :destroy if you need callbacks
                      
  def create_token
    token = (0...43).map { rand(65..90).chr }.join
    access_tokens.create(resource_owner_id: id, token: token, expires_in: 7200)
  end
end
