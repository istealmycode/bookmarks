require 'rails_helper'

RSpec.describe "/bookmarks", type: :request do
  let(:user) { create(:user) } 

  before do
    sign_in user
  end
  
  let(:valid_attributes) {
    {
      title: Faker::Book.title,
      url: Faker::Internet.url,
      description: Faker::Lorem.sentence,
      user: user
    }
  }

  let(:invalid_attributes) {
    {
      title: nil,
      url: Faker::Internet.url,
      description: Faker::Lorem.sentence,
      user: user
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Bookmark.create! valid_attributes
      get bookmarks_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      bookmark = Bookmark.create! valid_attributes
      get bookmark_url(bookmark)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_bookmark_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      bookmark = Bookmark.create! valid_attributes
      get edit_bookmark_url(bookmark)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Bookmark" do
        expect {
          post bookmarks_url, params: { bookmark: valid_attributes }
        }.to change(Bookmark, :count).by(1)
      end

      it "redirects to the created bookmark" do
        post bookmarks_url, params: { bookmark: valid_attributes }
        expect(response).to redirect_to(bookmark_url(Bookmark.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Bookmark" do
        expect {
          post bookmarks_url, params: { bookmark: invalid_attributes }
        }.to change(Bookmark, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post bookmarks_url, params: { bookmark: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          title: Faker::Book.title,
          url: Faker::Internet.url,
          description: Faker::Lorem.sentence,
          user: user
        }
      }

      it "updates the requested bookmark" do
        bookmark = Bookmark.create! valid_attributes
        patch bookmark_url(bookmark), params: { bookmark: new_attributes }
        bookmark.reload
        expect(bookmark).to have_attributes(new_attributes)
      end

      it "redirects to the bookmark" do
        bookmark = Bookmark.create! valid_attributes
        patch bookmark_url(bookmark), params: { bookmark: new_attributes }
        bookmark.reload
        expect(response).to redirect_to(bookmark_url(bookmark))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        bookmark = Bookmark.create! valid_attributes
        patch bookmark_url(bookmark), params: { bookmark: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested bookmark" do
      bookmark = Bookmark.create! valid_attributes
      expect {
        delete bookmark_url(bookmark)
      }.to change(Bookmark, :count).by(-1)
    end

    it "redirects to the bookmarks list" do
      bookmark = Bookmark.create! valid_attributes
      delete bookmark_url(bookmark)
      expect(response).to redirect_to(bookmarks_url)
    end
  end
end
