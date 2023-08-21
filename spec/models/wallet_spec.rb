require 'rails_helper'

RSpec.describe Wallet, type: :model do
  let(:user) { User.create(username: 'linda') }
  subject { WalletDeposit.new(wallet_id: user.wallet.id, amount: 50000) }

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

    it 'should be not valid when amount is greather_than than 10000000' do
      subject.amount = 10000001
    end

    after do
      expect(subject).to_not be_valid
    end
  end
end
