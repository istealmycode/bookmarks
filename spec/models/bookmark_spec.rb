# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:title) }
    context 'when the URL is invalid' do
      it 'is not valid' do
        bookmark = build(:bookmark, url: 'invalid-url')
        expect(bookmark).not_to be_valid
      end

      it 'adds an error message' do
        bookmark = build(:bookmark, url: 'invalid-url')
        bookmark.valid?
        expect(bookmark.errors[:url]).to include('is not a valid URL')
      end
    end

    context 'when the URL is valid' do
      it 'is valid' do
        bookmark = build(:bookmark, url: 'http://www.validurl.com')
        expect(bookmark).to be_valid
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:taggings) }
    it { should have_many(:tags).through(:taggings) }
    it { should have_many(:tags).through(:taggings).class_name('Tag') }
  end

  describe 'tag_list' do
    let(:bookmark) { create(:bookmark, tag_list: 'tag1, tag2') }

    it 'can be created with tags' do
      expect(bookmark.tags.pluck(:name)).to contain_exactly('tag1', 'tag2')
    end

    it 'can be updated with new tags' do
      bookmark.update(tag_list: 'tag3, tag4')
      expect(bookmark.tags.pluck(:name)).to contain_exactly('tag3', 'tag4')
    end

    it 'can retrieve the tags' do
      expect(bookmark.tag_list).to eq('tag1, tag2')
    end
  end

  describe 'callbacks' do
    let(:bookmark) { build(:bookmark, tag_list: 'tag1, tag2') }
    it 'creates tags after save' do
      expect { bookmark.save }.to change { Tag.count }.by(2)
    end

    it 'removes tags before destroy' do
      bookmark.save
      expect { bookmark.destroy }.to change { Tag.count }.by(-2)
    end
  end
end
