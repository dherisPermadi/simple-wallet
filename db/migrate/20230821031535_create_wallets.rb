class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.references :user
      t.decimal    :balance, precision: 20, default: 0

      t.timestamps
    end
  end
end
