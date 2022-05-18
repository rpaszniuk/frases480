require 'rails_helper'

RSpec.describe 'Phrases', type: :request do
  RSpec.shared_context 'common' do
    let!(:category_1) { create(:category) }
    let!(:category_2) { create(:category) }
    let!(:user_1) { create(:user) }
    let!(:user_2) { create(:user) }

    before do
      5.times do
        create(:phrase, user: user_1, category: category_1)
      end
      5.times do
        create(:phrase, user: user_2, category: category_2)
      end
      5.times do
        create(:phrase, user: user_2, category: category_1)
      end
    end
  end

  describe '#phrases' do
    let(:result) { JSON.parse(response.body) }

    context 'when fetching all phrases' do
      include_context 'common'

      it 'returns all the phrases' do
        get web_searches_phrases_url({ q: '', format: :json })

        expect(response).to be_successful
        expect(result.size).to eq(category_1.phrases.size + category_2.phrases.size)
      end
    end
  end
end
