# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/bookmarks', type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  let(:valid_attributes) do
    {
      title: Faker::Book.title,
      url: Faker::Internet.url,
      description: Faker::Lorem.sentence,
      user:
    }
  end

  let(:invalid_attributes) do
    {
      title: nil,
      url: Faker::Internet.url,
      description: Faker::Lorem.sentence,
      user:
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Bookmark.create! valid_attributes
      get bookmarks_url
      expect(response).to be_successful
    end

    context 'when filtering by term' do
      let!(:one_bookmark) do
        create(:bookmark, user:, title: "Bob's Bookmark", description: "This is Bob's bookmark", url: 'http://example.com',
                          tags: [create(:tag, name: 'bob')])
      end
      let!(:another_bookmark) do
        create(:bookmark, user:, title: 'Another Bookmark', description: 'This is another bookmark',
                          url: 'http://example.com/another', tags: [create(:tag, name: 'another')])
      end

      before do
        get bookmarks_url, params: { filter: 'bob' }
      end

      it 'returns results with the filter term in the title' do
        expect(CGI.unescapeHTML(response.body)).to include("Bob's bookmark")
      end

      it 'does not return unmatched results' do
        expect(CGI.unescapeHTML(response.body)).to_not include('Another bookmark')
      end
    end

    context 'when filtering by tag' do
      let!(:one_bookmark) do
        create(:bookmark, user:, title: 'A Bookmark', description: 'This is a bookmark', url: 'http://example.com',
                          tags: [create(:tag, name: 'bob')])
      end
      let!(:one_bookmark) do
        create(:bookmark, user:, title: 'A Bookmark', description: 'This is a bookmark', url: 'http://example.com',
                          tags: [create(:tag, name: 'robert')])
      end

      before do
        get bookmarks_url, params: { tag: 'bob' }
      end

      it 'returns results with the filter term in the title' do
        expect(CGI.unescapeHTML(response.body)).to include('Bob')
      end

      it 'does not return unmatched results' do
        expect(CGI.unescapeHTML(response.body)).to_not include('Robert')
      end
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      bookmark = Bookmark.create! valid_attributes
      get bookmark_url(bookmark)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_bookmark_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      bookmark = Bookmark.create! valid_attributes
      get edit_bookmark_url(bookmark)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Bookmark' do
        expect do
          post bookmarks_url, params: { bookmark: valid_attributes }
        end.to change(Bookmark, :count).by(1)
      end

      it 'redirects to the created bookmark' do
        post bookmarks_url, params: { bookmark: valid_attributes }
        expect(response).to redirect_to(bookmark_url(Bookmark.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Bookmark' do
        expect do
          post bookmarks_url, params: { bookmark: invalid_attributes }
        end.to change(Bookmark, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post bookmarks_url, params: { bookmark: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          title: Faker::Book.title,
          url: Faker::Internet.url,
          description: Faker::Lorem.sentence,
          user:
        }
      end

      it 'updates the requested bookmark' do
        bookmark = Bookmark.create! valid_attributes
        patch bookmark_url(bookmark), params: { bookmark: new_attributes }
        bookmark.reload
        expect(bookmark).to have_attributes(new_attributes)
      end

      it 'redirects to the bookmark' do
        bookmark = Bookmark.create! valid_attributes
        patch bookmark_url(bookmark), params: { bookmark: new_attributes }
        bookmark.reload
        expect(response).to redirect_to(bookmark_url(bookmark))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        bookmark = Bookmark.create! valid_attributes
        patch bookmark_url(bookmark), params: { bookmark: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested bookmark' do
      bookmark = Bookmark.create! valid_attributes
      expect do
        delete bookmark_url(bookmark)
      end.to change(Bookmark, :count).by(-1)
    end

    it 'redirects to the bookmarks list' do
      bookmark = Bookmark.create! valid_attributes
      delete bookmark_url(bookmark)
      expect(response).to redirect_to(bookmarks_url)
    end
  end
end
