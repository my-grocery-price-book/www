Rails.application.routes.draw do
  get 'invites/new'

  get 'item_purchases/create'

  root 'pages#index'

  resources :price_book, only: [] do
    resources :invites, only: [:new, :create]
  end

  resources :invites, only: [:show] do
    member do
      patch 'accept'
      patch 'reject'
    end
  end

  resources :shopping_lists, only: [:index, :create, :update, :destroy] do
    resources :items, controller: 'shopping_list_items', only: [:index, :create]
  end

  resources :shopping_list_items, only: [:update, :destroy] do
    resource :purchases, controller: 'shopping_list_item_purchases', only: [:create, :destroy]
  end

  resources :price_book_pages do
    member do
      get 'delete'
    end
  end

  devise_for :shoppers
  resource :profile, except: [:new, :create, :destroy]

  get 'price_check' => 'price_check#index', as: 'price_check'
  post 'select_area' => 'price_check#set_selected_area'
  get 'select_area' => 'price_check#select_area'

  resources :purchases, except: [:new, :show] do
    member do
      get 'delete'
      patch 'complete'
    end
    resources :items, controller: 'purchase_items', only: [:create, :update, :destroy] do
      member do
        get 'delete'
      end
    end
  end

  post 'guest_login' => 'guest#login', as: 'guest_login'
  get 'guest_register' => 'guest#register', as: 'guest_register'
  patch 'guest_register' => 'guest#do_register'
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
end
