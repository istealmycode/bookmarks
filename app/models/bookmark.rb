class Bookmark < ApplicationRecord
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings
  validates :url, presence: true
  validates :title, presence: true

end
