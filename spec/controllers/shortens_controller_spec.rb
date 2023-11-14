require 'rails_helper'

RSpec.describe Api::ShortensController, type: :controller do
  describe 'GET #show' do
    let(:shorten) { create(:shorten) }

    it 'redirects to the original URL' do
      get :show, params: { short_url: shorten.shortened_url }
      expect(response).to redirect_to(shorten.original_url)
    end

    it 'renders an error message if the shorten does not exist' do
      get :show, params: { short_url: 'nonexistent_url' }
      expect(response.body).to include("The Page you're looking for doesn't exist.")
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:valid_shorten_params) { attributes_for(:shorten) }
    let(:invalid_shorten_params) { attributes_for(:shorten, original_url: nil) }

    let(:payload) { { user_id: user.id } }
    let(:token) { JwtTokenable.generate_jwt_token(payload) }

    context 'when the creation is successful' do
      it 'returns a JSON response with the created shorten' do
        request.headers['Authorization'] = token
        post :create, params: valid_shorten_params
        expect(response).to have_http_status(:success)
        expect(response.body).to include('shortened_url')
      end
    end

    context 'when the creation fails' do
      it 'returns a JSON response with errors' do
        request.headers['Authorization'] = token
        post :create, params: invalid_shorten_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('errors')
      end
    end

    context 'when the user is not authenticated' do

      it 'returns a JSON response with an unauthorized status' do
        post :create, params: valid_shorten_params
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('errors')
      end
    end
  end
end
