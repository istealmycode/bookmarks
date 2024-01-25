class Bookmark < ApplicationRecord
  belongs_to :user
  validates :url, presence: true
  validates :title, presence: true
end
