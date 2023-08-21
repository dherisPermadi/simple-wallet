class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable

  has_many :access_grants, class_name: 'Doorkeeper::AccessGrant',
                           foreign_key: :resource_owner_id,
                           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens, class_name: 'Doorkeeper::AccessToken',
                           foreign_key: :resource_owner_id,
                           dependent: :delete_all # or :destroy if you need callbacks

  validates :username, presence: true, uniqueness: true                         
                           
  validate :username_validation, on: :create

  def create_token
    token = (0...43).map { rand(65..90).chr }.join
    application_id = Doorkeeper::Application.first&.id
    access_tokens.create(
      resource_owner_id: id, application_id: application_id, token: token, expires_in: 7200)
  end

  private

  def email_required?
    false
  end

  def username_validation
    errors.add(:base, 'Username is empty') if username.blank?
  end
end
