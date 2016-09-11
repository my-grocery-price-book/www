# frozen_string_literal: true
require 'test_helper'
require_relative 'shopping_list_items_helper'

class ShoppingListItemsUpdateActionTest < ShoppingListItemsControllerTest
  attr_reader :shopping_list_item

  setup do
    create_shopping_list_and_sign_in
    @shopping_list_item = shopping_list.items.create!
  end

  should 'update the item' do
    patch :update, params: { id: shopping_list_item.to_param,
                             shopping_list_id: shopping_list.to_param,
                             shopping_list_item: { amount: 111 } }

    shopping_list_item.reload
    assert_equal 111, shopping_list_item.amount
  end

  should 'redirect to shopping_list_path' do
    patch :update, params: { id: shopping_list_item.to_param,
                             shopping_list_id: shopping_list.to_param,
                             shopping_list_item: { amount: 111 } }
    assert_redirected_to shopping_list_items_path(shopping_list)
  end

  should 'be success for json format' do
    patch :update, params: { id: shopping_list_item.to_param,
                             shopping_list_id: shopping_list.to_param,
                             format: 'json',
                             shopping_list_item: { amount: 111 } }
    assert_response :success
  end

  should 'raise error if shopping_list_item does not exist' do
    assert_raise ActiveRecord::RecordNotFound do
      patch :update, params: { id: 'asdasd',
                               shopping_list_id: shopping_list.to_param,
                               format: 'json',
                               shopping_list_item: { amount: 111 } }
    end
  end

  should 'raise error if shopping_list does not exist' do
    assert_raise ActiveRecord::RecordNotFound do
      patch :update, params: { id: shopping_list_item.to_param,
                               shopping_list_id: 'asdasd',
                               format: 'json',
                               shopping_list_item: { amount: 111 } }
    end
  end

  should 'raise error if shopping_list item belong to another shopper' do
    other_shopping_list = ShoppingList.create!(shopper: create_shopper)
    other_shopping_list_item = other_shopping_list.items.create!
    assert_raise ActiveRecord::RecordNotFound do
      patch :update, params: { id: other_shopping_list_item.to_param,
                               shopping_list_id: shopping_list_item.to_param,
                               format: 'json',
                               shopping_list_item: { amount: 111 } }
    end
  end

  should 'raise error if shopping_list belong to another shopper' do
    other_shopping_list = ShoppingList.create!(shopper: create_shopper)
    assert_raise ActiveRecord::RecordNotFound do
      patch :update, params: { id: shopping_list_item.to_param,
                               shopping_list_id: other_shopping_list.to_param,
                               format: 'json',
                               shopping_list_item: { amount: 111 } }
    end
  end
end
