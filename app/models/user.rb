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
end
