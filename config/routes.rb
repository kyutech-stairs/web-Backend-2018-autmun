Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # get 'users', to: 'users#index' #userを全て取得する
  # get 'users/:id', to: 'users#show' #指定のuserを取得
  # post 'users', to: 'users#create' #渡されたparamからuserを作成
  # put 'users/:id', to: 'users#update' #渡されたparamからuserを更新
  # delete 'users/:id', to: 'users#destroy' #指定したuserを削除

  # get 'users/:id/tweets', to: 'users/tweets#index' #あるユーザに紐づいたtweetを全て取得
  
  # get 'tweets', to: 'tweets#index' #userを全て取得する
  # get 'tweets/:id', to: 'tweets#show' #指定のuserを取得
  # post 'tweets', to: 'tweets#create' #渡されたparamからuserを作成
  # put 'tweets/:id', to: 'tweets#update' #渡されたparamからtweetsを更新
  # delete 'tweets/:id', to: 'tweets#destroy' #指定したuserを削除
  
  # できるだけRailsに頼った方が良いので　resourcesを用いてRESTfulに
  resources :users, only: [:index, :show, :create, :update, :destroy] do
    resources :tweets, module: :users, only: [:index]
  end

  resources :tweets, only: [:index, :show, :create, :update, :destroy]
end

