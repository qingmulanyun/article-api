FactoryBot.define do
  factory :article do
    title { Faker::Name.name }
    date { Date.current }
    body { 'test body' }
    tags { ['health', 'science'] }
  end
end
