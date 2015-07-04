Rails.application.routes.draw do
  resources :regular_items

  get 'regular_items/:id/delete' => 'regular_items#delete', as: :delete_regular_items

  comfy_route :cms_admin, :path => '/_admin_'

  devise_for :shoppers
  resources :purchases, except: [:show] do
    member do
      get 'delete'
    end
    resources :items, controller: 'purchase_items' do
      member do
        get 'delete'
      end
    end
  end

  # Make sure this routeset is defined last
  comfy_route :cms, :path => '/', :sitemap => false
end
