# frozen_string_literal: true
require 'test_helper'
require_relative 'shopping_list_items_helper'

class ShoppingListItemsLatestActionTest < ShoppingListItemsControllerTest
  setup do
    create_shopping_list_and_sign_in
  end

  should 'be success' do
    get :latest
    assert_response :success
  end

  should 'be last created shopping list' do
    ShoppingList.create!(title: 'Final List', price_book_id: price_book.id)
    get :latest
    assert_includes response.body, 'Final List'
  end

  should 'redirect to shopping lists if not shopping list exist' do
    shopping_list.destroy
    get :latest
    assert_redirected_to shopping_lists_path
  end
end
