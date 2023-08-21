require 'rails_helper'

RSpec.describe Wallet, type: :model do
  let(:user) { User.create(username: 'linda') }
  subject { Wallet.new(user_id: user.id, balance: 0) }

  context 'valid when all column is assigned' do
    it 'should be valid when all column is assigned' do
      expect(subject).to be_valid
    end
  end
end
