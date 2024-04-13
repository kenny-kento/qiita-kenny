class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  
  default_scope -> { order('created_at DESC') }

  def formatted_created_at
    created_at.strftime('%Y年%m月%d日')
  end

  def formatted_updated_at
    updated_at.strftime('%Y年%m月%d日')
  end
end
