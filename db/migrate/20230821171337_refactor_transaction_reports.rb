class RefactorTransactionReports < ActiveRecord::Migration[7.0]
  def change
    remove_reference :transaction_reports, :source_user, index: true
    remove_reference :transaction_reports, :target_user, index: true
    remove_column :transaction_reports, :target_username
    rename_column :transaction_reports, :source_username, :username
    add_reference :transaction_reports, :user, index: true
  end
end
