Rails.application.routes.draw do
   root to: 'toppages#index'
   
   #ログイン用
   get 'login', to: 'sessions#new'
   post 'login', to: 'sessions#create'
   delete 'logout', to: 'sessions#destroy'
   
   #ユザーの新規登録のURLを/signupにしたい。
   get 'signup', to: 'users#new'
   
   resources :users, only: [:index, :show, :create] do
      member do
         get :followings
         get :followers
      end
   end
   
   #投稿に関するルーティング
   resources :microposts, only: [:create, :destroy]
   
   #フォロー/アンフォロー出来る様にするルーティング
   resources :relationships, only: [:create, :destroy]
end
