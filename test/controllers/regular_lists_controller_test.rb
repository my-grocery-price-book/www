require 'test_helper'

class RegularListsControllerTest < ActionController::TestCase
  setup do
    @regular_list = regular_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:regular_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create regular_list" do
    assert_difference('RegularList.count') do
      post :create, regular_list: { category: @regular_list.category, name: @regular_list.name }
    end

    assert_redirected_to regular_list_path(assigns(:regular_list))
  end

  test "should show regular_list" do
    get :show, id: @regular_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @regular_list
    assert_response :success
  end

  test "should update regular_list" do
    patch :update, id: @regular_list, regular_list: { category: @regular_list.category, name: @regular_list.name }
    assert_redirected_to regular_list_path(assigns(:regular_list))
  end

  test "should destroy regular_list" do
    assert_difference('RegularList.count', -1) do
      delete :destroy, id: @regular_list
    end

    assert_redirected_to regular_lists_path
  end
end
