Rails.application.routes.draw do
  get 'search/search'
  devise_for :users
  root to: 'homes#top'
  get '/search' => 'search#search'
  
  resources :reviews do
    resource :favorites, only: [:create, :destroy]
    
    resources :review_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
