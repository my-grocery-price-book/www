require 'test_helper'

class PurchasesControllerTest < ActionController::TestCase
  setup do
    @purchase = purchases(:grant_purchase)
    sign_in :shopper, shoppers(:grant)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_equal assigns(:purchases), [purchases(:grant_purchase)]
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchase" do
    assert_difference('Purchase.count') do
      post :create, purchase: { location: @purchase.location, purchased_on: @purchase.purchased_on, store: @purchase.store }
    end

    assert_redirected_to purchase_items_path(assigns(:purchase))
  end

  test "should show purchase" do
    get :show, id: @purchase
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @purchase
    assert_response :success
  end

  test "should update purchase" do
    patch :update, id: @purchase, purchase: { location: @purchase.location, purchased_on: @purchase.purchased_on, store: @purchase.store }
    assert_redirected_to purchase_path(assigns(:purchase))
  end

  test "should destroy purchase" do
    assert_difference('Purchase.count', -1) do
      delete :destroy, id: @purchase
    end

    assert_redirected_to purchases_path
  end
end
