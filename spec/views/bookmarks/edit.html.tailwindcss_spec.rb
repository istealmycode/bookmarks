require 'rails_helper'

RSpec.describe "bookmarks/edit", type: :view do
  let(:user) { create(:user) } 

  let(:valid_attributes) {
    {
      title: Faker::Book.title,
      url: Faker::Internet.url,
      description: Faker::Lorem.sentence,
      user: user
    }
  }

  let(:bookmark) {
    Bookmark.create!(valid_attributes)
  }

  before(:each) do
    assign(:bookmark, bookmark)
  end

  it "renders the edit bookmark form" do
    render

    assert_select "form[action=?][method=?]", bookmark_path(bookmark), "post" do
    end
  end
end
