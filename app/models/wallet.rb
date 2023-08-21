class Wallet < ApplicationRecord
  has_many :wallet_transactions, dependent: :destroy
  belongs_to :user
end
