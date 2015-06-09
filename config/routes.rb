Rails.application.routes.draw do
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
