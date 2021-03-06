Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'search/search'
  get "home/map" => "homes#map"
  get "/search" => "searches#search"
  get "reviews/area" => "reviews#area"

  resources :reviews do
    resource :favorites, only: [:create, :destroy]
    resources :review_comments, only: [:create, :destroy]
  end

  resources :tags do
    get 'reviews', to: 'reviews#search'
  end

  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    member do
      get :like
    end
  end
 
end
