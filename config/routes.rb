Rails.application.routes.draw do
  resources :works
  resource :welcome, only: :show

  root to: "welcomes#show", as: "welcome_path"

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  # get "/users/current", to: "users#current", as: "current_user"
end
