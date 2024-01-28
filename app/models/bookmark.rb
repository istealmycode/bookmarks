class Bookmark < ApplicationRecord
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings
  validates :url, presence: true
  validates :title, presence: true
  attr_accessor :tag_list

  after_save :save_tags
  before_destroy :destroy_tags


  def tag_list
    @tag_list || generate_tag_list
  end

  private

  def destroy_tags
    tags.each(&:destroy)
  end
  
  def generate_tag_list
    tags.pluck(:name).join(', ')
  end

  def save_tags
    return unless @tag_list
    tag_names = @tag_list.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name, user:user) }
    self.tags = new_or_found_tags
  end
end
