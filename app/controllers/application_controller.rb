class ApplicationController < ActionController::Base
   
   include SessionsHelper #追記
   include Pagy::Backend
   
   private
   
   def require_user_logged_in
      unless logged_in?
         redirect_to login_url
      end
   end
   
   def counts(user)
      #投稿の数
      @count_microposts = user.microposts.count
      #フォローしている数
      @count_followings = user.followings.count
      #フォローされている数
      @count_followers = user.followers.count
   end
end
