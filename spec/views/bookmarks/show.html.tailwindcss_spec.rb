require 'rails_helper'

RSpec.describe "bookmarks/show", type: :view do
  let(:user) { create(:user) } 

  let(:valid_attributes) {
    {
      title: Faker::Book.title,
      url: Faker::Internet.url,
      description: Faker::Lorem.sentence,
      user: user
    }
  }
  
  before(:each) do
    assign(:bookmark, Bookmark.create!(valid_attributes))
  end

  it "renders attributes in <p>" do
    render
  end
end
