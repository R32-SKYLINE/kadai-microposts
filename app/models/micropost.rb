class Micropost < ApplicationRecord
  #Micropostは１人のユーザーに所属
  belongs_to :user
  
  validates :content, presence: true, length: {maximum: 255 }
end
