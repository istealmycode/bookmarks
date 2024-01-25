require 'rails_helper'

RSpec.describe "bookmarks/index", type: :view do
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
    assign(:bookmarks, [
      Bookmark.create!(valid_attributes),
      Bookmark.create!(valid_attributes)
    ])
  end

  it "renders a list of bookmarks" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
