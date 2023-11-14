require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { described_class.new }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }

    it 'validates password length' do
      user.password = '12345'
      user.valid?

      expect(user.errors[:password]).to include('must be at least 6 characters')
    end

    it 'does not allow case-insensitive duplicate emails' do
      existing_user = create(:user, email: 'user@example.com')

      user = build_stubbed(:user, email: existing_user.email.upcase)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('has already been taken')
    end
  end

  describe 'callbacks' do
    it 'downcases email before validation' do
      user.email = 'Test@Example.com'
      user.valid?

      expect(user.email).to eq('test@example.com')
    end
  end

  describe 'has_secure_password' do
    it { is_expected.to have_secure_password }
  end
end
