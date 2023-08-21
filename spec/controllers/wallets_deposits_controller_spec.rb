require 'rails_helper'

RSpec.describe Api::V1::WalletDepositsController, type: :controller do
  context 'authorized' do
    let(:application) { create(:application) }
    let(:user) { create(:user) }
    let(:token) { create(:access_token, application: application, resource_owner_id: user.id) }

    before(:each) do
      request.headers["Authorization"] = "Bearer #{token.token}"
    end

    context 'create new wallet deposits' do
      it "create should return 200" do
        post :create, params: { wallet_deposit: { amount: 100000 } }
        expect(response).to have_http_status(:ok)
      end

      it "create should return 400 if amount is incorrect" do
        post :create, params: { wallet_deposit: { amount: 0 } }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  context "invalid Authorization header" do
    it "returns a 401" do
      request.headers["Authorization"] = "bar"
      post :create, params: { wallet_deposit: { amount: 100000 } }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
