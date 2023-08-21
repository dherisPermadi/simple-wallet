class WalletTransaction < ApplicationRecord
  extend Enumerize

  belongs_to :wallet_transaction
  belongs_to :wallet

  enum event: { credit: 0, debit: 1 }

  validate :check_balance, on: :create

  private

  def check_balance
    wallet.with_lock do
      if event.eql?('credit') && wallet.balance < amount.abs
        errors.add(:base, "Transfer failed, Wallet balance is not enough!")
      end
    end
  end
end
