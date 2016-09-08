# frozen_string_literal: true
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
  get 'contact' => 'pages#contact'
  get 'thank_you' => 'pages#thank_you'

  get 'price_book_pages' => 'menu#price_book_pages'

  resources :books, only: [:edit, :update] do
    resources :regions, controller: 'book_regions', only: [] do
      collection do
        get 'select_country'
        get ':country_code/new', action: 'new', as: 'new'
        post ':country_code', action: 'create', as: ''
      end
    end
    resources :invites, only: [:new, :create]
    resources :stores, controller: 'book_stores', only: [:new, :create]
    resources :pages, controller: 'price_book_pages' do
      member do
        get 'delete'
      end
      resources :entries, only: [:new, :create, :edit, :update]
    end
    resources :entry_suggestions, only: [:index]
    resources :shopping_items, controller: 'shopping_list_items', only: [] do
      collection do
        get 'names'
      end
    end
  end

  resources :invites, only: [:show] do
    member do
      patch 'accept'
      patch 'reject'
    end
  end

  resources :shopping_lists, only: [:index, :create, :update, :destroy] do
    resources :items, controller: 'shopping_list_items',
                      only: [:index, :create, :update, :destroy] do
      resource :purchases, controller: 'shopping_list_item_purchases', only: [:create, :destroy]
    end
  end

  resources :shopping_list_items, only: [] do
    collection do
      get 'latest'
    end
  end

  devise_for :shoppers
  resource :profile, except: [:new, :create, :destroy]

  post 'guest_login' => 'guest#login', as: 'guest_login'
  get 'guest_register' => 'guest#register', as: 'guest_register'
  patch 'guest_register' => 'guest#do_register'
  post '/callmeback/oneall' => 'oneall#callback', as: 'oneall_callback'
end
