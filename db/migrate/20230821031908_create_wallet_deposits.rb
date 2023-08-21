class CreateWalletDeposits < ActiveRecord::Migration[7.0]
  def change
    create_table :wallet_deposits do |t|
      t.references :wallet
      t.decimal    :amount, precision: 8

      t.timestamps
    end
  end
end
