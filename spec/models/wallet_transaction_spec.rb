require 'rails_helper'

RSpec.describe WalletTransaction, type: :model do
  let(:source) { User.create(username: 'linda') }
  let(:wallet_deposit) { WalletDeposit.create(wallet_id: source.wallet.id, amount: 500000) }
  let(:target) { User.create(username: 'john') }
  subject {
    WalletTransaction.new(
      source_user_id: wallet_deposit.wallet.user_id, target_user_id: target.id, amount: 50000
    ) 
  }

  context 'valid when all column is assigned' do
    it 'should be valid when all column is assigned' do
      expect(subject).to be_valid
    end
  end

  describe "# not valid when ?" do
    it 'should be not valid when amount is equal 0' do
      subject.amount = 0
    end

    it 'should be not valid when amount is less than 0' do
      subject.amount = -0.1
    end

    after do
      expect(subject).to_not be_valid
    end
  end
end
