class Review < ApplicationRecord
  
  attachment :image
  
  belongs_to :user
  has_many :review_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
    
    old_tags.each do |old|
      self.review_tags.delete ReviewTag.find_by(tag_name: old)
    end
    
    new_tags.each do |new|
      new_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_tag
    end
  end
  
end
