require 'test_helper'

class PurchaseItemsControllerTest < ActionController::TestCase
  setup do
    @shopper = create(:shopper)
    @purchase = create(:purchase, shopper: @shopper)
    @purchase_item = create(:purchase_item, purchase_id: @purchase.id)
    sign_in :shopper, @shopper
  end

  context 'GET index' do
    should 'be succesful' do
      get :index, purchase_id: @purchase
      assert_response :success
      assert_not_nil assigns(:purchase_items)
    end
  end

  context 'GET index' do
    should 'be success' do
      get :new, purchase_id: @purchase
      assert_response :success
    end
  end

  context 'POST create' do
    setup do
      @item_params = { 'product_brand_name' => 'Coke Like',
                       'package_size' => '500.0',
                       'package_unit' => 'ml',
                       'quanity' => '1.0',
                       'total_price' => '38.99',
                       'category' => 'Drinks',
                       'regular_name' => 'Soda' }
    end

    should 'create purchase_item' do
      assert_difference('PurchaseItem.count') do
        post :create, purchase_id: @purchase, purchase_item: @item_params
      end
    end

    should 'permit correct params' do
      post :create, purchase_id: @purchase_item.purchase_id, purchase_item: @item_params
      item_attributes = assigns(:purchase_item).attributes.except('id', 'purchase_id', 'created_at', 'updated_at')
      item_attributes.each { |key,value| item_attributes[key] = value.to_s }
      assert_equal(@item_params,item_attributes)
    end

    should 'redirect to purchase_items_path' do
      post :create, purchase_id: @purchase_item.purchase_id, purchase_item: @item_params
      assert_redirected_to purchase_items_path(assigns(:purchase))
    end
  end

  context 'GET show' do
    should 'show purchase_item' do
      get :show, id: @purchase_item, purchase_id: @purchase
      assert_response :success
    end
  end

  context 'GET edit' do
    should 'be success' do
      get :edit, id: @purchase_item, purchase_id: @purchase
      assert_response :success
    end
  end

  context 'PATCH update' do
    should 'update purchase_item' do
      patch :update,  id: @purchase_item,
                      purchase_id: @purchase,
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
        delete :destroy, id: @purchase_item, purchase_id: @purchase
      end

      assert_redirected_to purchase_items_path(assigns(:purchase))
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
