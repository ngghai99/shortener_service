# spec/models/shorten_spec.rb
require 'rails_helper'

RSpec.describe Shorten, type: :model do
  subject(:shorten) { build(:shorten) }
  let(:invalid_url) { 'example' }
  let(:invalid_url_http) { 'example.com' }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:original_url) }
    it { is_expected.to validate_uniqueness_of(:original_url) }

    it { is_expected.to allow_value('http://www.example.com').for(:original_url) }
    it { is_expected.to allow_value('https://www.example.com').for(:original_url) }

    it { is_expected.not_to allow_value(invalid_url).for(:original_url) }

    it { is_expected.to validate_presence_of(:shortened_url) }
    it { is_expected.to validate_uniqueness_of(:shortened_url) }

    it { is_expected.to allow_value('GeAi9K').for(:shortened_url) }

  end

  describe 'custom validation' do
    it 'validates the format of the original_url' do
      shorten.original_url = invalid_url
      shorten.valid?

      expect(shorten.errors[:original_url]).to include('is invalid')
    end

    it 'validates that original_url starts with http:// or https://' do
      shorten.original_url = invalid_url_http
      shorten.valid?

      expect(shorten.errors[:original_url]).to include('Must start with http:// or https://')
    end
  end
end
