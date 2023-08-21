class AddTransactionTypeToTransferReports < ActiveRecord::Migration[7.0]
  def change
    add_column :transfer_reports, :transfer_type, :string
  end
end
