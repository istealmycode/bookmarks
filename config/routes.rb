# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :bookmarks
  root 'bookmarks#index'
  resources :tags
end
