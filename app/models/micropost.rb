class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: {maximum: 255 }
  
  has_many :favorites
  has_many :favoriters, through: :favorites, source: :user
  has_many :reverses_of_favorite, class_name: 'Favorite', foreign_key: 'user_id'
  
end
