# frozen_string_literal: true
require 'test_helper'

class ShoppingListItemsControllerTest < ActionController::TestCase
  context 'POST create' do
    setup do
      @shopper = create_shopper
      @price_book = PriceBook.create!(shopper: @shopper)
      @shopping_list = ShoppingList.create!(price_book_id: @price_book.id)
      sign_in @shopper, scope: :shopper
    end

    setup do
      @item_params = { 'name' => 'Test', 'amount' => 123, 'unit' => 'ml' }
    end

    should 'create shopping_list_item' do
      assert_difference('ShoppingList::Item.count') do
        post :create, params: { shopping_list_id: @shopping_list.to_param,
                                shopping_list_item: @item_params }
      end

      saved_params = ShoppingList::Item.last.attributes.slice('name', 'amount', 'unit')
      assert_equal(saved_params, @item_params)
    end

    should 'create shopping_list_item using json' do
      assert_difference('ShoppingList::Item.count') do
        post :create, params: { shopping_list_id: @shopping_list.to_param,
                                shopping_list_item: @item_params,
                                format: 'json' }
      end
    end

    should 'set shopping_list' do
      post :create, params: { shopping_list_id: @shopping_list.to_param,
                              shopping_list_item: @item_params }
      assert_equal(@shopping_list.id, ShoppingList::Item.last.shopping_list_id)
    end

    should 'redirect to shopping_list_path' do
      post :create, params: { shopping_list_id: @shopping_list.to_param,
                              shopping_list_item: @item_params }
      assert_redirected_to shopping_list_items_path(@shopping_list)
    end

    should 'raise error if shopping_list does not exist' do
      assert_raise ActiveRecord::RecordNotFound do
        post :create, params: { shopping_list_id: 'sa11', shopping_list_item: @item_params }
      end
    end

    should 'raise error if shopping_list belong to another shopper' do
      other_shopping_list = ShoppingList.create!(shopper: create_shopper)
      assert_raise ActiveRecord::RecordNotFound do
        post :create, params: { shopping_list_id: other_shopping_list.to_param,
                                shopping_list_item: @item_params }
      end
    end
  end
end
