# frozen_string_literal: true

require 'rails_helper'
require 'webdrivers'

# WebDrivers Gem
# https://github.com/titusfortner/webdrivers
#
# Official Guides about System Testing
# https://api.rubyonrails.org/v5.2/classes/ActionDispatch/SystemTestCase.html

RSpec.describe 'Phrases', type: :system do
  before do
    driven_by :selenium, using: :chrome
    # If using Firefox
    # driven_by :selenium, using: :firefox
    #
    # If running on a virtual machine or similar that does not have a UI, use
    # a headless driver
    # driven_by :selenium, using: :headless_chrome
    # driven_by :selenium, using: :headless_firefox
  end

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

  describe 'index' do
    it 'shows a list of phrases and categories' do
      visit web_root_path
      # expect page to show 15 phrases
      expect(Phrase.count).to eq(15)
      # expect the page to show the last record added
      expect(page).to have_text(Phrase.last.phrase)
      expect(page).to have_text('Bienvenido al sitio web de frases de hasta 480 caracteres: Frases 480.')
      # expect page to show 2 categories
      expect(Category.count).to eq(2)
    end
  end

  describe 'show' do
    let(:category) { create(:category, slug: 'test-category') }
    let(:phrase) { create(:phrase, category_id: category.id, slug: 'test-phrase') }
    it 'shows a phrase' do
      visit web_show_phrase_path(phrase.category.slug, phrase.slug)
      # expect page to show the phrase
      expect(page).to have_text(phrase.phrase)
      # expect url format category/phrase
      expect(current_path).to have_content("#{phrase.category.slug}/#{phrase.slug}")
    end

    context 'when not found' do
      it 'shows a 404 page' do
        visit web_show_phrase_path('azertywxcvbn-test', 'azertywxcvbn2-test')
        # expect page to be a 404
        expect(page).to have_text('The page you were looking for doesn\'t exist.')
      end
    end
  end
end
