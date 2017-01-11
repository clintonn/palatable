Rails.application.routes.draw do
  root to: 'application#index'
  resources :users, only: [:show, :create]
  resources :reviews, except: [:index]
  resources :upvotes, only: [:create, :destroy]
  resources :restaurants, only: [:show, :create]
  resources :searches, only: [:create, :update]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  post '/new_restaurant' => 'restaurants#dummy_create'
  get '/search/:query' => 'searches#show', as: 'search_result'

end
