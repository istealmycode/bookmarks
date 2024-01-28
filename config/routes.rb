Rails.application.routes.draw do
  devise_for :users
  resources :bookmarks do
    get 'tagged/:tag', to: 'bookmarks#index_by_tag', on: :collection, as: :tagged
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "bookmarks#index"
  resources :tags
end
