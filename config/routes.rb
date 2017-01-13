Rails.application.routes.draw do
  root to: 'application#index'
  resources :users, only: [:show, :create, :edit, :update, :delete, :destroy]
  get '/reviews/new' => 'reviews#dummy_new', as: 'dummy_review'
  resources :reviews, except: [:index, :new]
  resources :upvotes, only: [:create, :destroy]
  resources :restaurants, only: [:show, :create]
  resources :searches, only: [:create, :update]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  post '/new_restaurant' => 'restaurants#dummy_create'
  get '/search/:query' => 'searches#show', as: 'search_result'
# conflict start
  get '/restaurants/:restaurant_id/reviews/new' => 'reviews#new', as: 'new_review'
  post '/restaurants/:restaurant_id/reviews' => 'reviews#create', as: 'post_review'
  # analytics page
  get '/analytics' => 'application#analytics', as: 'analytics'
  post '/preview' => 'reviews#homepage_poster', as: 'post_from_homepage'
end
