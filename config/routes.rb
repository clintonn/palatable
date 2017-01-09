Rails.application.routes.draw do

  resources :users, only: [:new, :create, :show]
  resources :reviews, except: [:index]
  resources :upvotes, only: [:create, :destroy]
  resources :restaurants, only: [:show, :create]
  resources :search, only: [:create, :destroy]

  root to: 'application#index'

end
