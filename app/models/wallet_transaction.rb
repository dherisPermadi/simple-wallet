class WalletTransaction < ApplicationRecord
  belongs_to :source_user, class_name: "User"
  belongs_to :target_user, class_name: "User"

  has_many :transaction_details, as: :taskable, dependent: :destroy

  validates :amount, numericality: { greater_than: 0 }

  validate :balance_validation, :source_and_target_validation, on: :create

  after_create :process_transaction

  attr_accessor :to_username

  private

  def balance_validation
    if source_user.wallet.balance < amount
      errors.add(:base, 'Transaction failed, Insufficient balance!')
    end
  end

  def source_and_target_validation
    return if source_user.blank?

    if source_user == target_user
      errors.add(:base, 'Transaction failed, Owner and Receiver cannot be same person!')
    end
  end

  def process_transaction
    process_wallet(source_user, 'credit')
    process_wallet(target_user, 'debit')
    process_transaction_report
  end

  def process_wallet(owner, event)
    new_amount      = event.eql?('debit') ? amount : -(amount)
    transfer_type   = event.eql?('debit') ? 'in' : 'out'
    new_transaction = owner.wallet.transaction_details.create(
      taskable_id: id, taskable_type: 'WalletTransaction', transaction_type: event, amount: new_amount
    )

    process_validation(new_transaction)
    process_report(new_amount, transfer_type)
  end

  def process_report(new_amount, transfer_type)
    new_transaction = TransferReport.create(
      source_user_id: source_user.id, source_username: source_user.username,
      target_user_id: target_user.id, target_username: target_user.username,
      amount: new_amount, transfer_type: transfer_type
    )

    process_validation(new_transaction)
  end

  def process_transaction_report
    report = TransactionReport.find_by_user_id(source_user.id)
    if report.present?
      update_transaction_report(report)
    else
      create_transaction_report
    end
  end

  def create_transaction_report
    new_transaction = TransactionReport.create(user_id: source_user.id, username: source_user.username, amount: amount)

    process_validation(new_transaction)
  end

  def update_transaction_report(report)
    report.with_lock do
      report.amount += amount
      report.save
    end
  end

  def process_validation(process)
    if process.errors.present?
      errors.add(:base, process.errors.full_messages.join(', '))
      raise ActiveRecord::Rollback
    end
  end
end
