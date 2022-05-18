FactoryBot.define do
  factory :phrase do
    phrase { Faker::Lorem.paragraph(sentence_count: 10) }
    slug { Faker::Lorem.unique.exclude :string, [number: 6], %w[azerty wxcvbn] }
    user { create(:user) }
    category { create(:category) }
  end
end
