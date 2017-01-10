Rails.application.routes.draw do

  resources :users, only: [:show, :create]
  resources :reviews, except: [:index]
  resources :upvotes, only: [:create, :destroy]
  resources :restaurants, only: [:show, :create]

  root to: 'application#index'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  post '/search' => 'search#create'
  post '/new_restaurant' => 'restaurants#dummy_create'

end
