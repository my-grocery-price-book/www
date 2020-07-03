# frozen_string_literal: true

require 'test_helper'

class ShoppingListsControllerTest < ActionController::TestCase
  setup do
    @shopper = create_shopper
    @price_book = PriceBook.default_for_shopper(@shopper)
    sign_in @shopper, scope: :shopper
  end

  context 'GET index' do
    should 'be success' do
      get :index
      assert_response :success
    end
  end

  context 'PATCH update' do
    setup do
      @shopping_list = ShoppingList.create!(shopper: @shopper)
    end

    should 'update shopping_list' do
      patch :update, params: { id: @shopping_list.to_param, shopping_list: { title: 'My Title' } }
      @shopping_list.reload

      assert_equal('My Title', @shopping_list.title)
    end

    should 'redirect to shopping_list_path' do
      patch :update, params: { id: @shopping_list.to_param, shopping_list: { title: 'My Title' } }
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

    should 'redirect to latest_shopping_list_items_path' do
      post :create
      assert_redirected_to latest_shopping_list_items_path
    end
  end

  context 'DELETE destroy' do
    setup do
      @shopping_list = ShoppingList.create!(shopper: @shopper)
    end

    should 'destroy shopping_list' do
      assert_difference('ShoppingList.count', -1) do
        delete :destroy, params: { id: @shopping_list }
      end

      assert_redirected_to shopping_lists_path
    end
  end
end
