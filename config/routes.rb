Rails.application.routes.draw do
  devise_for :users
  root 'books#index'
  resources :books, except: [:show] do
    resources :records, except: [:show]
    resources :categories, except: [:show]
  end
end