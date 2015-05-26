Rails.application.routes.draw do

  root 'purchases#index'
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
