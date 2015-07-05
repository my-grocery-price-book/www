require 'test_helper'

class RegularItemsControllerTest < ActionController::TestCase
  setup do
    @regular_item = regular_items(:grant_regular_item)
    sign_in :shopper, shoppers(:grant)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_equal assigns(:regular_items), [regular_items(:grant_regular_item)]
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create regular_item" do
    assert_difference('RegularItem.count') do
      post :create, regular_item: { category: @regular_item.category, name: @regular_item.name }
    end

    assert_redirected_to regular_item_path(assigns(:regular_item))
  end

  test "should show regular_item" do
    get :show, id: @regular_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @regular_item
    assert_response :success
  end

  test "should update regular_item" do
    patch :update, id: @regular_item, regular_item: { category: @regular_item.category, name: @regular_item.name }
    assert_redirected_to regular_item_path(assigns(:regular_item))
  end

  test "should destroy regular_item" do
    assert_difference('RegularItem.count', -1) do
      delete :destroy, id: @regular_item
    end

    assert_redirected_to regular_items_path
  end
end
