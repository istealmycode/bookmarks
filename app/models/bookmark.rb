class Bookmark < ApplicationRecord
  belongs_to :user
  validates :url, presence: true
  validates :title, presence: true
  has_many :taggings
  has_many :tags, through: :taggings
end
