class WalletDeposit < ApplicationRecord
  belongs_to :wallet

  has_many :transaction_details, as: :taskable, dependent: :destroy

  validates :amount, numericality: { greater_than: 0, less_than: 10000001 }

  after_create :process_transaction

  private

  def process_transaction
    new_transaction = wallet.transaction_details.create(
      taskable_id: id, taskable_type: 'WalletDeposit', transaction_type: 'debit', amount: amount
    )

    if new_transaction.errors.present?
      errors.add(:base, process.errors.full_messages.join(', '))
      raise ActiveRecord::Rollback
    end
  end
end
