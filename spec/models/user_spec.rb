require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(first_name: 'John', last_name: 'Smith', email: 'info@frases480.com', password: '123456')
  end

  describe 'Validations' do
    it { should belong_to(:access_profile).without_validating_presence }
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations' do
    it { should have_many(:phrases) }
  end
end
