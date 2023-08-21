class RefactorSourceAndTargetAttributesOnWalletTransactions < ActiveRecord::Migration[7.0]
  def change
    remove_reference :wallet_transactions, :sourceable, index: true
    remove_reference :wallet_transactions, :targetable, index: true
    add_reference :wallet_transactions, :source_user
    add_reference :wallet_transactions, :target_user
  end
end
