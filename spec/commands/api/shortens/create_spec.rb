require 'rails_helper'

RSpec.describe Api::Shortens::Create do
  describe '#call' do
    let(:valid_params) { { original_url: 'https://www.rendi.com' } }
    let(:invalid_params) { { original_url: 'example' } }
    let(:existing_shorten) { create(:shorten, original_url: 'https://www.example.com') }

    context 'when the original_url is already shortened' do
      it 'returns a JSON response with existing shortened URL' do
        command = described_class.new(valid_params.merge(original_url: existing_shorten.original_url)).call

        expect(command.success?).to be_truthy

        expected_response = ShortenPresenter.new(existing_shorten).json_response
        expect(command.result).to eq(expected_response)
      end
    end

    context 'when the original_url is not yet shortened' do
      let(:valid_params) { { original_url: 'https://www.rendi.vn' } }
      it 'creates a new Shorten and returns a JSON response with shortened URL' do
        command = described_class.new(valid_params).call

        expect(command.success?).to be_truthy

        shorten = Shorten.last
        expected_response = ShortenPresenter.new(shorten).json_response
        expect(command.result).to eq(expected_response)
      end
    end

    context 'when an error occurs during save' do
      it 'raises an error and adds errors to the command' do
        command = described_class.new(invalid_params).call

        expect(command.success?).to be_falsey
        expect(command.errors).to have_key(:errors)
      end
    end
  end
end
