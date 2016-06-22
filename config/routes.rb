Rails.application.routes.draw do
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"

  resources :products, only: [:show, :index]
  resources :categories, only: [:show, :index]
end
