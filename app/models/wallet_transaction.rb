class Transaction < ApplicationRecord
  extend Enumerize
  belongs_to :sourceable, polymorphic: true
  belongs_to :targetable, polymorphic: true, optional: true

  has_many :transaction_details, dependent: :destroy

  validates :amount, numericality: { greater_than: 0 }

  validate :source_and_target_validation, on: :create
  validate :transfer_validation, on: :create, if: -> { transaction_type.eql?('transfer') }

  after_create :generate_wallet
  after_create :process_transaction

  def sourceable_balance
    sourceable&.wallet&.balance
  end

  def targetable_balance
    targetable.present? ? targetable&.wallet&.balance : 0
  end

  private

  def source_and_target_validation
    return if sourceable.blank?

    if sourceable == targetable
      errors.add(:base, 'Transaction failed, Owner and Receiver cannot be same person!')
    end
  end
  
  def transfer_validation
    if targetable.blank?
      errors.add(:base, 'Transaction failed, Tranfer target is no exist!')
    end
  end

  def generate_wallet
    generate_target_wallet(sourceable) if sourceable.wallet.blank?
    generate_target_wallet(targetable) if targetable.present? && targetable&.wallet.blank?
  end

  def generate_target_wallet(owner)
    new_wallet = owner.create_wallet

    process_validation(new_wallet)
  end

  def process_transaction
    if transaction_type.eql?('deposit')
      process_wallet(sourceable, 'debit')
    else
      process_wallet(sourceable, 'credit') # deduction of source wallet
      process_wallet(targetable, 'debit') # addition of target wallet
    end
  end

  def process_wallet(owner, event)
    new_amount      = event.eql?('debit') ? amount : -(amount)
    new_transaction = owner.wallet.transaction_details.create(transaction_id: id, event: event, amount: new_amount)

    process_validation(new_transaction)
  end

  def process_validation(process)
    if process.errors.present?
      errors.add(:base, process.errors.full_messages.join(', '))
      raise ActiveRecord::Rollback
    end
  end
end
