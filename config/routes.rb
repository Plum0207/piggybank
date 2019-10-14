Rails.application.routes.draw do
  devise_for :users
  root 'books#index'
  resources :books, except: [:show] do
    resources :records, except: [:show] do
      post :import, on: :collection
    end
    resources :categories, except: [:show] do
      post :import, on: :collection
    end
  end
end