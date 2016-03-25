# == Schema Information
#
# Table name: shopping_lists
#
#  id                              :integer          not null, primary key
#  _deprecated_shopper_id          :integer
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  title                           :string
#  price_book_id                   :integer
#  _deprecated_shopper_id_migrated :boolean          default(FALSE), not null
#

require 'test_helper'

class ShoppingListsControllerTest < ActionController::TestCase
  setup do
    @shopper = create_shopper
    @price_book = PriceBook.for_shopper(@shopper)
    sign_in :shopper, @shopper
  end

  context 'GET index' do
    should 'be success' do
      get :index
      assert_response :success
    end

    should 'assign own shopping_lists' do
      ShoppingList.create!(shopper: create_shopper)
      list = ShoppingList.create!(shopper: @shopper)
      get :index
      assert_equal([list], assigns(:shopping_lists))
    end
  end

  context 'PATCH update' do
    setup do
      @shopping_list = ShoppingList.create!(shopper: @shopper)
    end

    should 'update shopping_list' do
      patch :update, id: @shopping_list.to_param, shopping_list: { title: 'My Title' }
      @shopping_list.reload

      assert_equal('My Title', @shopping_list.title)
    end

    should 'redirect to shopping_list_path' do
      patch :update, id: @shopping_list.to_param, shopping_list: { title: 'My Title' }
      assert_redirected_to shopping_lists_path
    end
  end

  context 'POST create' do
    should 'create shopping_list' do
      assert_difference('ShoppingList.count') do
        post :create
      end

      assert_equal(@price_book.id, ShoppingList.last.price_book_id)
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
