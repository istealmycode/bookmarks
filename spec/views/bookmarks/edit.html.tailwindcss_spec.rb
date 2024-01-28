# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'bookmarks/edit', type: :view do
  let(:user) { create(:user) }

  let(:valid_attributes) do
    {
      title: Faker::Book.title,
      url: Faker::Internet.url,
      description: Faker::Lorem.sentence,
      user:
    }
  end

  let(:bookmark) do
    Bookmark.create!(valid_attributes)
  end

  before(:each) do
    assign(:bookmark, bookmark)
  end

  it 'renders the edit bookmark form' do
    render

    assert_select 'form[action=?][method=?]', bookmark_path(bookmark), 'post'
  end
end
