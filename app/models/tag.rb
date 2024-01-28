class Tag < ApplicationRecord
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :bookmarks, through: :taggings
  
  def to_s
    name
  end
end