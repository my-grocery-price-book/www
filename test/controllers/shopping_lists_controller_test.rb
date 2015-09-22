require 'test_helper'

class ShoppingListsControllerTest < ActionController::TestCase
  setup do
    @shopper = create(:shopper)
    sign_in :shopper, @shopper
  end

  context 'GET index' do
    should 'be success' do
      get :index
      assert_response :success
    end

    should 'assign own shopping_lists' do
      create(:shopping_list, shopper: create(:shopper))
      list = create(:shopping_list, shopper: @shopper)
      get :index
      assert_equal([list], assigns(:shopping_lists))
    end
  end

  context 'POST create' do
    should 'create shopping_list' do
      assert_difference('ShoppingList.count') do
        post :create
      end

      assert_equal(@shopper, ShoppingList.last.shopper)
    end

    should 'redirect to shopping_list_path' do
      post :create
      assert_redirected_to shopping_list_path(ShoppingList.last)
    end
  end

  context 'GET show' do
    setup do
      @shopping_list = create(:shopping_list, shopper: @shopper)
    end

    should 'be success' do
      get :show, id: @shopping_list.to_param
      assert_response :success
    end

    should 'assign shopping list' do
      get :show, id: @shopping_list.to_param
      assert_equal(@shopping_list, assigns(:shopping_list))
    end
  end

  context 'GET delete' do
    setup do
      @shopping_list = create(:shopping_list, shopper: @shopper)
    end

    should 'be success' do
      get :show, id: @shopping_list.to_param
      assert_response :success
    end

    should 'assign shopping list' do
      get :show, id: @shopping_list.to_param
      assert_equal(@shopping_list, assigns(:shopping_list))
    end
  end

  context 'DELETE destroy' do
    setup do
      @shopping_list = create(:shopping_list, shopper: @shopper)
    end

    should 'destroy shopping_list' do
      assert_difference('ShoppingList.count', -1) do
        delete :destroy, id: @shopping_list
      end

      assert_redirected_to shopping_lists_path
    end
  end
end
