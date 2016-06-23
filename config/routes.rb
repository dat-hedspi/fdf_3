Rails.application.routes.draw do

  root "static_pages#home"
  get "about" => "static_pages#about"
  get "help" => "static_pages#help"
  get "signup"  => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :products, only: [:show, :index]
  resources :categories, only: [:show, :index]
  resources :users, only: [:create, :show, :edit, :update]
  namespace :admin do
    resources :categories, only: [:create, :new, :index]
  end
end
