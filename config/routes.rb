Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root to: 'books#index', as: :authenticated_root
    end
    unauthenticated :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :books, except: [:show] do
    resources :records, except: [:show] do
      post :import, on: :collection
    end
    resources :categories, except: [:show] do
      post :import, on: :collection
      get :download, on: :collection
    end
    resources :charts, only: [:index]
  end
  resources :users, only: [:index]

end