Rails.application.routes.draw do

  devise_for :shoppers
  root to: 'purchases#index'
  resources :purchases do
    member do
      get 'delete'
    end
    resources :items, controller: 'purchase_items' do
      member do
        get 'delete'
      end
    end
  end
end
