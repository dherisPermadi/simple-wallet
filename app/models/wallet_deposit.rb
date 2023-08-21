class WalletDeposit < ApplicationRecord
  extend Enumerize
  belongs_to :wallet

  validates :amount, numericality: { greater_than: 0, less_than: 10000001 }

  after_create :update_wallet

  private

  def update_wallet
    wallet.with_lock do
      wallet.balance += amount
      wallet.save
    end
  end
end
