Rails.application.routes.draw do
   root to: 'toppages#index'
   
   #ユザーの新規登録のURLを/signupにしたい。
   get 'signup', to: 'users#new'
   
   resources :users, only: [:index, :show, :create]
end
