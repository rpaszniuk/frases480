require 'rails_helper'

RSpec.describe Phrase, type: :model do
  subject do
    described_class.new(phrase: 'test test test test test test test test test test test test', user_id: 1, category_id: 1, slug: 'test')
  end

  describe 'Validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:category) }

    it 'is not valid without a phrase' do
      subject.phrase = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations' do
    it { should belong_to(:category) }
    it { should belong_to(:user) }
  end
end
