Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :reviews do
    resource :favorites, only: [:create, :destroy]
    
    resources :review_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:show, :index, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
