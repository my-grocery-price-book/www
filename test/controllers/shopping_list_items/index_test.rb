require 'test_helper'

class ShoppingListItemsControllerTest < ActionController::TestCase
  context 'GET index' do
    setup do
      @shopper = create_shopper
      @price_book = PriceBook.create!(shopper: @shopper)
      @shopping_list = ShoppingList.create!(price_book_id: @price_book.id)
      sign_in @shopper, scope: :shopper
    end

    should 'be success' do
      get :index, params: { shopping_list_id: @shopping_list.to_param }
      assert_response :success
    end
  end
end
