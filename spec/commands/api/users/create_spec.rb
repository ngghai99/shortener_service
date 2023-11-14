require 'rails_helper'

RSpec.describe Api::Users::Create do
  describe '#call' do
    let(:valid_params) { { email: 'user@example.com', password: 'password', first_name: 'Ngghai', last_name: 'Hai' } }
    let(:invalid_params) { { email: 'user@example.com' } }

    context 'when the user is successfully created' do
      it 'returns a JSON response with user data' do
        command = described_class.new(valid_params).call

        expect(command.success?).to be_truthy

        user = User.last
        expected_response = UserPresenter.new(user).json_response

        expect(command.result).to eq(expected_response)
      end
    end

    context 'when there are validation errors' do
      it 'raises an error and adds errors to the command' do
        command = described_class.new(invalid_params).call

        expect(command.success?).to be_falsey
        expect(command.errors).to have_key(:errors)
      end
    end
  end
end
