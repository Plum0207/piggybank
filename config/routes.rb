Rails.application.routes.draw do
  devise_for :users
  root 'books#index'
  resources :books, except: [:show]
end