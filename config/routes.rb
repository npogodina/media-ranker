Rails.application.routes.draw do
  resources :works
  
  resource :welcome, only: :show
  root to: "welcomes#show"

  resources :users, only: [:index, :show]
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
end
