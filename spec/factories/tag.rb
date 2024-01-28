# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.word }
    user { create(:user) }

    trait :with_bookmarks do
      after(:create) do |tag|
        create_list(:bookmark, 3, user: tag.user, tags: [tag])
      end
    end
  end
end
