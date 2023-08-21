require 'rails_helper'

RSpec.describe Api::V1::WalletTransactionsController, type: :controller do
  context 'authorized' do
    let(:application) { create(:application) }
    let(:source) { User.create(username: 'linda') }
    let(:wallet_deposit) { WalletDeposit.create(wallet_id: source.wallet.id, amount: 500000) }
    let(:token) { create(:access_token, application: application, resource_owner_id: wallet_deposit.wallet.user_id) }
    let(:user) { create(:user) }

    before(:each) do
      request.headers["Authorization"] = "Bearer #{token.token}"
    end

    context 'create new wallet transactions' do
      it "create should return 204" do
        post :create, params: { to_username: user.username, wallet_transaction: { amount: 100000 } }
        expect(response).to have_http_status(:no_content)
      end

      it "create should return 400 if balance is insufficient" do
        post :create, params: { to_username: user.username, wallet_transaction: { amount: 500001 } }
        expect(response).to have_http_status(:bad_request)
      end

      it "create should return 404 if destionation is not found" do
        post :create, params: { to_username: 'test', wallet_transaction: { amount: 10000 } }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  context "invalid Authorization header" do
    let(:user) { create(:user) }
    it "returns a 401" do
      request.headers["Authorization"] = "bar"
      post :create, params: { to_username: user.username, wallet_transaction: { amount: 100000 } }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
