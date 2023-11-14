require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  describe 'POST #create' do
    let(:valid_user) { create(:user, email: 'user@example.com', password: 'password') }

    context 'when the user provides valid credentials' do
      it 'returns a JSON response with user and token' do
        post :create, params: { email: valid_user.email, password: 'password' }

        expect(response).to have_http_status(:success)

        response_data = JSON.parse(response.body)
        expect(response_data).to include('user', 'auth_token')
      end
    end

    context 'when the user provides invalid credentials' do
      it 'returns a JSON response with an error message' do
        post :create, params: { email: 'invalid@example.com', password: 'wrong_password' }

        expect(response).to have_http_status(:unauthorized)

        response_data = JSON.parse(response.body)
        expect(response_data).to include('errors')
      end
    end
  end
end
