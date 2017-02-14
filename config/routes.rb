Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :users do
      member do
        get :new_configure
        post :configure
        get :new_deposit
        post :deposit
      end
    end

    resources :orders do
      member do
        get :set_result
        post :save_result
      end

      collection do
        get :search
      end
    end

    resources :quotations
    resources :agent_ranks

    resources :projects do
      resources :products, shallow: true do
        resources :quotations, only: [:new, :create,]
      end
    end
  end

  namespace :account do
    resources :orders, only: [:index, :show]
    resources :account_books, only: [:index]
  end

  get '/projects', to: 'projects#index', as: 'projects'
  get '/projects/:id', to: 'projects#show', as: 'project'
  get '/products/:id', to: 'products#show', as: 'product'
  get '/products/:product_id/orders/new', to: 'orders#new', as: 'new_product_order'
  post '/products/:product_id/orders', to: 'orders#create', as: 'product_orders'

  namespace :robot do
    resources :orders, only: [] do
      collection do
        get :queue
        get :done
      end
    end

    resources :stocks, only: [] do
      collection do
        get :synchronize
      end
    end
  end

#  resources :projects, only: [:index, :show] do
#    resources :products, only: [:index, :show]
#  end
#
#  resources :products, only: [] do
#    resources :orders, only: [:new, :create]
#  end

  root 'projects#index'
  resource :welcome, controller: :welcome
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
