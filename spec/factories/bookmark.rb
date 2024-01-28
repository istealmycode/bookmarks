FactoryBot.define do
  factory :bookmark do
    user { create(:user) }
    url { Faker::Internet.url } 
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end
end