# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'bookmarks/index', type: :view do
  let(:user) { create(:user) }

  let(:valid_attributes) do
    {
      title: Faker::Book.title,
      url: Faker::Internet.url,
      description: Faker::Lorem.sentence,
      user:
    }
  end

  before do
    2.times do
      Bookmark.create!(valid_attributes)
    end
    assign(:bookmarks, Bookmark.paginate(page: 1, per_page: 1))
  end

  it 'renders a list of bookmarks' do
    render
    Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
