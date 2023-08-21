class CreateTransactionDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :transaction_details do |t|
      t.references :wallet_transaction
      t.references :wallet
      t.string     :transaction_type, null: false
      t.decimal    :amount, precision: 8

      t.timestamps
    end
  end
end
