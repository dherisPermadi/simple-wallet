require 'rails_helper'

RSpec.describe Api::V1::TransactionDetailsController, type: :controller do
  context 'authorized' do
    let(:application) { create(:application) }
    let(:source) { User.create(username: 'linda') }
    let(:wallet_deposit) { WalletDeposit.create(wallet_id: source.wallet.id, amount: 500000) }
    let(:token) { create(:access_token, application: application, resource_owner_id: wallet_deposit.wallet.user_id) }
    let(:user) { User.create(username: 'james') }
    let(:another_user) { create(:user) }
    let(:first_transaction) {
      WalletTransaction.create(
        source_user_id: wallet_deposit.wallet.user_id, target_user_id: user.id, amount: 50000
      )
    }
    let(:second_transaction) {
      WalletTransaction.create(
        source_user_id: wallet_deposit.wallet.user_id, target_user_id: another_user.id, amount: 50000
      )
    }

    before(:each) do
      request.headers["Authorization"] = "Bearer #{token.token}"
    end

    context 'show top transaction' do
      it "create should return 200" do
        get :top_transaction
        expect(response).to have_http_status(:ok)
      end
    end

    context 'show top overall transaction' do
      it "create should return 200" do
        get :top_overall
        expect(response).to have_http_status(:ok)
      end
    end
  end

  context "invalid Authorization header" do
    context 'show top transaction' do
      it "returns a 401" do
        request.headers["Authorization"] = "bar"
        get :top_transaction
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'show top overall transaction' do
      it "returns a 401" do
        request.headers["Authorization"] = "bar"
        get :top_overall
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
