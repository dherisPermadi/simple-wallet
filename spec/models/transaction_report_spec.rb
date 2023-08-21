require 'rails_helper'

RSpec.describe TransactionReport, type: :model do
  let(:source) { User.create(username: 'linda') }
  let(:wallet_deposit) { WalletDeposit.create(wallet_id: source.wallet.id, amount: 500000) }
  let(:target) { User.create(username: 'john') }
  subject {
    TransactionReport.new(
      source_user_id: source.wallet.user_id, source_username: source.username,
      target_user_id: target.id, target_username: target.username,
      amount: 50000
    )
  }

  context 'valid when all column is assigned' do
    it 'should be valid when all column is assigned' do
      expect(subject).to be_valid
    end
  end
end
