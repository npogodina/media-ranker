Rails.application.routes.draw do
  root to: "welcomes#show", as: "welcome_path"
  resources :works
end
