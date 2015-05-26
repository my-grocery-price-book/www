require 'test_helper'

class PurchaseItemsControllerTest < ActionController::TestCase
  setup do
    @purchase_item = purchase_items(:one)
    sign_in :shopper, shoppers(:grant)
  end

  test "should get index" do
    get :index, purchase_id: @purchase_item.purchase_id
    assert_response :success
    assert_not_nil assigns(:purchase_items)
  end

  test "should get new" do
    get :new, purchase_id: @purchase_item.purchase_id
    assert_response :success
  end

  test "should create purchase_item" do
    assert_difference('PurchaseItem.count') do
      post :create, purchase_id: @purchase_item.purchase_id,
                    purchase_item: { generic_name: @purchase_item.generic_name, package_size: @purchase_item.package_size,
                                     package_type: @purchase_item.package_type, package_unit: @purchase_item.package_unit,
                                     product_brand_name: @purchase_item.product_brand_name,
                                     quanity: @purchase_item.quanity, total_price: @purchase_item.total_price }
    end

    assert_redirected_to purchase_item_path(assigns(:purchase),assigns(:purchase_item))
  end

  test "should show purchase_item" do
    get :show, id: @purchase_item, purchase_id: @purchase_item.purchase_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @purchase_item, purchase_id: @purchase_item.purchase_id
    assert_response :success
  end

  test "should update purchase_item" do
    patch :update,  id: @purchase_item,
                    purchase_id: @purchase_item.purchase_id,
                    purchase_item: { generic_name: @purchase_item.generic_name, package_size: @purchase_item.package_size,
                                     package_type: @purchase_item.package_type, package_unit: @purchase_item.package_unit,
                                     product_brand_name: @purchase_item.product_brand_name,
                                     quanity: @purchase_item.quanity, total_price: @purchase_item.total_price }
   assert_redirected_to purchase_item_path(assigns(:purchase),assigns(:purchase_item))
  end

  test "should destroy purchase_item" do
    assert_difference('PurchaseItem.count', -1) do
      delete :destroy, id: @purchase_item, purchase_id: @purchase_item.purchase_id
    end

    assert_redirected_to purchase_items_path(assigns(:purchase))
  end

  test "should get delete" do
    get :delete, id: @purchase_item, purchase_id: @purchase_item.purchase_id
    assert_response :success
    assert_not_nil assigns(:purchase_item)
  end
end
