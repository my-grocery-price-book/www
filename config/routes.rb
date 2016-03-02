Rails.application.routes.draw do
  root 'pages#index'

  resources :shopping_lists, except: [:new, :edit] do
    resources :items, controller: 'shopping_list_items', only: [:index, :create, :destroy] do
      member do
        post 'done'
      end
    end
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
end
