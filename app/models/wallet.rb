class Wallet < ApplicationRecord
  has_many :transaction_details, dependent: :destroy
  belongs_to :user
end
