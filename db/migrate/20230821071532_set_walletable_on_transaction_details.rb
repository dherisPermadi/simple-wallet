class SetWalletableOnTransactionDetails < ActiveRecord::Migration[7.0]
  def change
    remove_reference :transaction_details, :wallet_transaction, index: true
    add_reference :transaction_details, :taskable, polymorphic: true
    add_index :transaction_details, [:taskable_id, :taskable_type]
  end
end
