require 'test_helper'

class ShoppingListItemsControllerTest < ActionController::TestCase
  context 'GET latest' do
    setup do
      @shopper = create_shopper
      @price_book = PriceBook.create!(shopper: @shopper)
      @shopping_list = ShoppingList.create!(price_book_id: @price_book.id)
      sign_in @shopper, scope: :shopper
    end

    should 'be success' do
      get :latest
      assert_response :success
    end

    should 'be last created shopping list' do
      ShoppingList.create!(title: 'Final List', price_book_id: @price_book.id)
      get :latest
      assert_includes response.body, 'Final List'
    end

    should 'redirect to shopping lists if not shopping list exist' do
      @shopping_list.destroy
      get :latest
      assert_redirected_to shopping_lists_path
    end
  end
end
