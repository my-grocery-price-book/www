require 'test_helper'

class RegularItemsControllerTest < ActionController::TestCase
  setup do
    @shopper = create(:shopper)
    @regular_item = create(:regular_item, shopper: @shopper)
    sign_in :shopper, @shopper
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_equal assigns(:regular_items), [@regular_item]
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create regular_item" do
    assert_difference('RegularItem.count') do
      post :create, regular_item: { category: 'Food', name: 'Banana' }
      assert_empty assigns(:regular_item).errors
    end

    assert_redirected_to regular_items_path
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
    assert_empty assigns(:regular_item).errors
    assert_redirected_to regular_item_path(assigns(:regular_item))
  end

  test "should destroy regular_item" do
    assert_difference('RegularItem.count', -1) do
      delete :destroy, id: @regular_item
    end

    assert_redirected_to regular_items_path
  end
end
