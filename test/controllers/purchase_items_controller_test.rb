require 'test_helper'

class PurchaseItemsControllerTest < ActionController::TestCase
  setup do
    @purchase_item = purchase_items(:grant_purchase_item)
    sign_in :shopper, shoppers(:grant)
  end

  context 'GET index' do
    should 'be succesful' do
      get :index, purchase_id: @purchase_item.purchase_id
      assert_response :success
      assert_not_nil assigns(:purchase_items)
    end
  end

  context 'GET index' do
    should 'be success' do
      get :new, purchase_id: @purchase_item.purchase_id
      assert_response :success
    end
  end

  context 'POST create' do
    should 'create purchase_item' do
      assert_difference('PurchaseItem.count') do
        post :create, purchase_id: @purchase_item.purchase_id,
                      purchase_item: { package_size: @purchase_item.package_size,
                                       package_unit: @purchase_item.package_unit,
                                       product_brand_name: 'Woolworths Bread',
                                       quanity: @purchase_item.quanity, total_price: @purchase_item.total_price }
      end

      assert_redirected_to purchase_items_path(assigns(:purchase))
    end
  end

  context 'GET show' do
    should 'show purchase_item' do
      get :show, id: @purchase_item, purchase_id: @purchase_item.purchase_id
      assert_response :success
    end
  end

  context 'GET edit' do
    should 'be success' do
      get :edit, id: @purchase_item, purchase_id: @purchase_item.purchase_id
      assert_response :success
    end
  end

  context 'PATCH update' do
    should 'update purchase_item' do
      patch :update,  id: @purchase_item,
                      purchase_id: @purchase_item.purchase_id,
                      purchase_item: { package_size: @purchase_item.package_size,
                                       package_unit: @purchase_item.package_unit,
                                       product_brand_name: @purchase_item.product_brand_name,
                                       quanity: @purchase_item.quanity, total_price: @purchase_item.total_price }
     assert_redirected_to purchase_item_path(assigns(:purchase),assigns(:purchase_item))
    end
  end

  context 'DELETE destroy' do
    should 'destroy purchase_item' do
      assert_difference('PurchaseItem.count', -1) do
        delete :destroy, id: @purchase_item, purchase_id: @purchase_item.purchase_id
      end

      assert_redirected_to purchase_items_path(assigns(:purchase))
    end
  end

  context 'GET delete' do
    should 'be success' do
      get :delete, id: @purchase_item, purchase_id: @purchase_item.purchase_id
      assert_response :success
      assert_not_nil assigns(:purchase_item)
    end
  end
end
