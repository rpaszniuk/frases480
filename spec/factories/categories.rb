FactoryBot.define do
  factory :category do
    name { Faker::Name.name }
    description { Faker::Name.name }
    slug { Faker::Lorem.unique.exclude :string, [number: 6], %w[azerty wxcvbn] }
  end
end
