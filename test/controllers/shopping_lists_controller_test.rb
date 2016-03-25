# == Schema Information
#
# Table name: shopping_lists
#
#  id         :integer          not null, primary key
#  shopper_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#

require 'test_helper'

class ShoppingListsControllerTest < ActionController::TestCase
  setup do
    @shopper = create_shopper
    sign_in :shopper, @shopper
  end

  context 'GET index' do
    should 'be success' do
      get :index
      assert_response :success
    end

    should 'assign own shopping_lists' do
      ShoppingList.create!(shopper_id: 0)
      list = ShoppingList.create!(shopper: @shopper)
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
      assert_redirected_to shopping_list_items_path(ShoppingList.last)
    end
  end

  context 'DELETE destroy' do
    setup do
      @shopping_list = ShoppingList.create!(shopper: @shopper)
    end

    should 'destroy shopping_list' do
      assert_difference('ShoppingList.count', -1) do
        delete :destroy, id: @shopping_list
      end

      assert_redirected_to shopping_lists_path
    end
  end
end
