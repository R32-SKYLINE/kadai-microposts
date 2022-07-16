class User < ApplicationRecord
   #Passwordの暗号化
   has_secure_password
   
   #emailのデータを保存する際に全て小文字に変換
   before_save { self.email.downcase! }
   
   #nameのバリデーション
   validates :name, presence: true, length: { maximum: 50 }
   
   #emailのバリデーション
   validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
                    
   #Userは複数のmicropostsを持つ
   has_many :microposts
   
   #フォロー関係のコード
   
   #多対多の自分がフォローしているUserへの参照
   has_many :relationships
   #自分がフォローしているUser達
   has_many :followings, through: :relationships, source: :follow
   #自分をフォローしているUserへの参照
   has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
   #自分をフォローしているUser達
   has_many :followers, through: :reverses_of_relationship, source: :user
   
   #メソッドの使用
   #user.followやuser.unfollowにて、フォロー/アンフォロー出来る様にする
   
   #フォローするとき
   def follow(other_user)
      unless self == other_user
         self.relationships.find_or_create_by(follow_id: other_user.id)
      end
   end
   
   #フォローを解除するとき
   def unfollow(other_user)
      relationship = self.relationships.find_by(follow_id: other_user.id)
      relationship.destroy if relationship
   end
   
   #既にフォロー済みか？
   def following?(other_user)
      self.followings.include?(other_user)
   end
end
