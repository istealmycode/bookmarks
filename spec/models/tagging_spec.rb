RSpec.describe Tagging, type: :model do
  describe 'associations' do
    it { should belong_to(:tag) }
    it { should belong_to(:bookmark) }
  end
end