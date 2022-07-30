class User < ApplicationRecord
   has_secure_password
   before_save { self.email.downcase! }
   
   validates :name, presence: true, length: { maximum: 50 }
   validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
                    
   has_many :microposts
   
   has_many :relationships
   has_many :followings, through: :relationships, source: :follow
   has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
   has_many :followers, through: :reverses_of_relationship, source: :user
   
   has_many :favorites
   has_many :favoriteings, through: :favorites, source: :micropost
   has_many :reverses_of_favorite, class_name: 'Favorite', foreign_key: 'micropost_id'
   
   def follow(other_user)
      unless self == other_user
         self.relationships.find_or_create_by(follow_id: other_user.id)
      end
   end
   
   def unfollow(other_user)
      relationship = self.relationships.find_by(follow_id: other_user.id)
      relationship.destroy if relationship
   end
   
   def following?(other_user)
      self.followings.include?(other_user)
   end
   
   def feed_microposts
      Micropost.where(user_id: self.following_ids + [self.id])
   end
   
   def favorite(other_microposts)
      self.favorites.find_or_create_by(micropost_id: other_microposts.id)
   end
   
   def unfavorite(other_microposts)
      favorite = self.favorites.find_by(micropost_id: other_microposts.id)
      favorite.destroy if favorite
   end
   
   def favoriteing?(other_microposts)
      self.favoriteings.include?(other_microposts)
   end
end
