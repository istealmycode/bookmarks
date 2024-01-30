# frozen_string_literal: true

require 'faker'

# Create a sample user
user = User.create(email: 'user@example.com', password: 'password')

# Seed bookmarks with tags using Faker for random data
10.times do
  user.bookmarks.create(
    title: Faker::Book.title,
    url: Faker::Internet.url,
    description: Faker::Lorem.sentence,
    tag_list: Faker::Lorem.words(number: rand(1..3)).join(', ')
  )
end

puts 'Seed data has been successfully added.'
