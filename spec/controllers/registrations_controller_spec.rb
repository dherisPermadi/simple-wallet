require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :request do
  let(:url) { '/api/v1/users' }
  let(:user) { User.create(username: 'myusername') }
  context 'User Registration' do
    before(:each) do
      Doorkeeper::Application.create!(name: 'API Client', scopes: '')
    end

    it "create should return 201" do
      post url, params: {
        registration: {
          username: 'mywallet'
        }
      }

      expect(response).to have_http_status(:created)
    end

    it "create should return 400 if error" do
      post url, params: {
        registration: {
          username: ''
        }
      }
      expect(response).to have_http_status(:bad_request)
    end

    it "create should return 409 if username is exist" do
      post url, params: {
        registration: {
          username: user.username
        }
      }

      expect(response).to have_http_status(:conflict)
    end
  end
end
