require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  describe 'POST #create' do
    context 'when the user creation is successful' do

      let(:valid_user_params) { attributes_for(:user, email: "ngghai@example.com") }
      it 'returns a JSON response with the created user' do
        post :create, params: valid_user_params

        expect(response).to have_http_status(:success)

        response_data = JSON.parse(response.body)
        expect(response_data).to include('email')
        expect(response_data).to include('id')
      end
    end

    context 'when the user creation fails' do
      let(:invalid_user_params) { attributes_for(:user, email: nil) }

      it 'returns a JSON response with errors' do
        post :create, params: invalid_user_params

        expect(response).to have_http_status(:unprocessable_entity)

        response_data = JSON.parse(response.body)
        expect(response_data).to include('errors')
      end
    end
  end
end
