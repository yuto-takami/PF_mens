class Review < ApplicationRecord
  attachment :image

  attr_accessor :tag_name

  belongs_to :user
  has_many :review_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps

  validates :image, presence: true
  validates :shop_name, presence: true
  validates :caption, presence: true
  validates :area, presence: true
  validates :evaluation, presence: true

  enum area: {
    北海道地方: 0, 東北地方: 1, 関東地方: 2, 中部地方: 3, 関西地方: 4, 中国地方: 5, 四国地方: 6, 九州地方: 7
  }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def save_tag(sent_tags)
    current_tags = tags.pluck(:tag_name) unless tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      review_tags.delete ReviewTag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_tag = Tag.find_or_create_by(tag_name: new)
      tags << new_tag
    end
  end

  def update_tag(sent_tags)
    current_tags = tags.pluck(:tag_name) unless tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      review_tags.delete ReviewTag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_tag = Tag.find_or_create_by(tag_name: new)
      tags << new_tag
    end
  end
end
