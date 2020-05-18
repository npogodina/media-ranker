Rails.application.routes.draw do
  resources :works
  resource :welcome, only: :show

  root to: "welcomes#show", as: "welcome_path"
end
