Rails.application.routes.draw do

  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "signup"  => "users#new"
  resources :users, only: [:create, :show]
  resources :products, only: [:show, :index]
  resources :categories, only: [:show, :index]
end
