require 'test_helper'

class PurchaseItemsControllerTest < ActionController::TestCase
  setup do
    @shopper = create_shopper
    @purchase = Purchase.create!(shopper: @shopper, purchased_on: Time.zone.today)
    @purchase_item = @purchase.items.create!
    sign_in :shopper, @shopper
  end

  context 'POST create' do
    should 'create purchase_item' do
      assert_difference('PurchaseItem.count') do
        post :create, purchase_id: @purchase
      end
    end

    should 'redirect to purchase_items_path' do
      post :create, purchase_id: @purchase
      assert_redirected_to edit_purchase_path(assigns(:purchase))
    end
  end

  context 'PATCH update' do
    setup do
      @item_params = { 'product_brand_name' => 'Coke Like',
                       'package_size' => '500.0',
                       'package_unit' => 'ml',
                       'quantity' => '1',
                       'total_price' => '38.99',
                       'category' => 'Drinks',
                       'regular_name' => 'Soda' }
    end

    should 'update purchase_item' do
      patch :update, id: @purchase_item, purchase_id: @purchase, purchase_item: @item_params
      assert_redirected_to edit_purchase_path(assigns(:purchase))
    end

    should 'permit correct params' do
      patch :update,  id: @purchase_item, purchase_id: @purchase, purchase_item: @item_params
      item_attributes = assigns(:purchase_item).attributes.except('id', 'purchase_id', 'created_at', 'updated_at')
      item_attributes.each { |key, value| item_attributes[key] = value.to_s }
      assert_equal(@item_params, item_attributes)
    end
  end

  context 'DELETE destroy' do
    should 'destroy purchase_item' do
      assert_difference('PurchaseItem.count', -1) do
        delete :destroy, id: @purchase_item, purchase_id: @purchase
      end

      assert_redirected_to edit_purchase_path(assigns(:purchase))
    end
  end

  context 'GET delete' do
    should 'be success' do
      get :delete, id: @purchase_item, purchase_id: @purchase
      assert_response :success
      assert_not_nil assigns(:purchase_item)
    end
  end
end
