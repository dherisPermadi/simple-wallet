class CreateTransactionReports < ActiveRecord::Migration[7.0]
  def change
    create_table :transaction_reports do |t|
      t.references :source_user
      t.string :source_username
      t.references :target_user
      t.string :target_username
      t.decimal :amount, precision: 20
      t.timestamps
    end
  end
end
