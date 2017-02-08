Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :users do
      member do
        get :new_configure
        post :configure
      end
    end
    resources :orders
    resources :quotations
    resources :agent_ranks

    resources :projects do
      resources :products, shallow: true
    end
  end

  namespace :account do
    resources :orders, only: [:index, :show]
  end

  get '/projects', to: 'projects#index', as: 'projects'
  get '/projects/:id', to: 'projects#show', as: 'project'
  get '/products/:id', to: 'products#show', as: 'product'
  get '/products/:product_id/orders/new', to: 'orders#new', as: 'new_product_order'
  post '/products/:product_id/orders', to: 'orders#create', as: 'product_orders'

#  resources :projects, only: [:index, :show] do
#    resources :products, only: [:index, :show]
#  end
#
#  resources :products, only: [] do
#    resources :orders, only: [:new, :create]
#  end

  root 'projects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
