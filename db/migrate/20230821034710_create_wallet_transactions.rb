class CreateWalletTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :wallet_transactions do |t|
      t.references :sourceable, polymorphic: true
      t.references :targetable, polymorphic: true
      t.decimal    :amount, precision: 15

      t.timestamps
    end
    add_index :wallet_transactions, [:sourceable_id, :sourceable_type]
    add_index :wallet_transactions, [:targetable_id, :targetable_type]
  end
end
