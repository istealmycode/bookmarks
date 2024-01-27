Rails.application.routes.draw do
  devise_for :users
  resources :bookmarks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "bookmarks#index"
  resources :tags
end
