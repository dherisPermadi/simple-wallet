class TransactionDetail < ApplicationRecord
  extend Enumerize

  belongs_to :taskable, polymorphic: true
  belongs_to :wallet

  enumerize :transaction_type, in: %i[debit credit], default: :debit, scope: :shallow

  after_create :update_wallet

  private

  def update_wallet
    wallet.with_lock do
      wallet.balance += amount
      wallet.save
    end
  end
end
