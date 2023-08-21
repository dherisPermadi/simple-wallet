require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  context 'valid when all column is assigned' do
    it 'should be valid when all column is assigned' do
      expect(subject).to be_valid
    end
  end

  describe "# not valid when ?" do
    it 'should be not valid when username nil' do
      subject.username = nil
    end

    after do
      expect(subject).to_not be_valid
    end
  end

  context 'create validation' do
    before(:each) do
      @user = subject
      @user.save
    end

    it 'will be not valid when username was not unique' do
      other_user = build(:user)
      expect(other_user).to_not be_valid
    end
  end
end
