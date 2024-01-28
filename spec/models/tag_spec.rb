RSpec.describe Tag, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:taggings).dependent(:destroy) }
    it { should have_many(:bookmarks).through(:taggings) }
  end

  describe '#to_s' do
    it 'returns the tag name' do
      tag = build(:tag, name: 'example_tag')
      expect(tag.to_s).to eq('example_tag')
    end
  end
end