require 'rails_helper'

RSpec.describe Api::V1::WalletsController, type: :controller do
  context 'authorized' do
    let(:application) { create(:application) }
    let(:user) { create(:user) }
    let(:token) { create(:access_token, application: application, resource_owner_id: user.id) }

    before(:each) do
      request.headers["Authorization"] = "Bearer #{token.token}"
    end

    context 'show total balance' do
      it 'should return 200' do
        get :total_balance
        expect(response).to have_http_status(:ok)
      end
    end
  end

  context "invalid Authorization header" do
    it "returns a 401" do
      request.headers["Authorization"] = "bar"
      get :total_balance
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
