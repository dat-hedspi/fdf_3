Rails.application.routes.draw do

  root "static_pages#home"
  get "about" => "static_pages#about"
  get "help" => "static_pages#help"
  get "signup"  => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :products, only: [:show, :index] do
    resources :comments, only: [:create, :destroy]
  end
  resources :comments
  resources :categories, only: [:show, :index]
  resources :users, except: [:destroy]
  namespace :admin do
    resources :users, only: [:destroy, :index]
    resources :categories
    resources :products
    resources :suggestions, only: [:index, :destroy]
  end
  resources :relationships, only: [:create, :destroy, :index]
  resources :rates, only: [:create]
  resources :suggestions, only: [:index, :create]
end
