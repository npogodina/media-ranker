Rails.application.routes.draw do
  resources :works
  post '/works/:id/upvote', to: 'votes#create', as: 'upvote'
  
  resource :welcome, only: :show
  root to: "welcomes#show"

  resources :users, only: [:index, :show]
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"

  resources :votes, only: :create
end
