# spec/models/user_spec.rb
RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:bookmarks).dependent(:destroy) }
    it { should have_many(:tags).dependent(:destroy) }
  end
end
