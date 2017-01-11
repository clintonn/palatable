Rails.application.routes.draw do

  resources :users, only: [:show, :create]
  get '/reviews/new' => 'reviews#dummy_new', as: 'dummy_review'
  resources :reviews, except: [:index, :new]
  resources :upvotes, only: [:create, :destroy]
  resources :restaurants, only: [:show, :create]

  root to: 'application#index'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  post '/search' => 'search#create'
  post '/new_restaurant' => 'restaurants#dummy_create'
  get '/restaurants/:restaurant_id/reviews/new' => 'reviews#new', as: 'new_review'
  post '/restaurants/:restaurant_id/reviews' => 'reviews#create', as: 'post_review'

end
