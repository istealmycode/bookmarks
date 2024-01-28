# spec/requests/tagged_bookmarks_spec.rb
require 'rails_helper'

RSpec.describe 'Tagged Bookmarks', type: :request do
  let(:user) { create(:user) }
  let(:tag) { create(:tag, user: user, name: 'example_tag') }
  let!(:tagged_bookmark) { create(:bookmark, user: user, tag_list: 'example_tag') }
  let!(:untagged_bookmark) { create(:bookmark, user: user, tag_list: 'other_tag') }

  describe 'GET /tagged_bookmarks/:tag' do
    before do
      sign_in user
      get tagged_bookmarks_path(tag: tag.name)
    end

    it 'responds with success' do
      expect(response).to have_http_status(:success)
    end

    it 'includes the bookmark with the specified tag' do
      expect(response.body).to include(tagged_bookmark.title)
    end

    it 'does not include the bookmark with a different tag' do
      expect(response.body).not_to include(untagged_bookmark.title)
    end
  end
end
