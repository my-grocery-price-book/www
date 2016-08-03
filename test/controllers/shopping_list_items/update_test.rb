require 'test_helper'

class ShoppingListItemsControllerTest < ActionController::TestCase
  context 'PATCH update' do
    setup do
      @shopper = create_shopper
      @price_book = PriceBook.create!(shopper: @shopper)
      @shopping_list = ShoppingList.create!(price_book_id: @price_book.id)
      sign_in @shopper, scope: :shopper
      @shopping_list_item = @shopping_list.items.create!
    end

    should 'update the item' do
      patch :update, params: { id: @shopping_list_item.to_param,
                               shopping_list_item: { amount: 111 } }

      @shopping_list_item.reload
      assert_equal 111, @shopping_list_item.amount
    end

    should 'redirect to shopping_list_path' do
      patch :update, params: { id: @shopping_list_item.to_param,
                               shopping_list_item: { amount: 111 } }
      assert_redirected_to shopping_list_items_path(@shopping_list)
    end

    should 'be success for json format' do
      patch :update, params: { id: @shopping_list_item.to_param,
                               format: 'json',
                               shopping_list_item: { amount: 111 } }
      assert_response :success
    end

    should 'raise error if shopping_list_item does not exist' do
      assert_raise ActiveRecord::RecordNotFound do
        patch :update, params: { id: 'asdasd',
                                 format: 'json',
                                 shopping_list_item: { amount: 111 } }
      end
    end

    should 'raise error if shopping_list item belong to another shopper' do
      other_shopping_list = ShoppingList.create!(shopper: create_shopper)
      other_shopping_list_item = other_shopping_list.items.create!
      assert_raise ActiveRecord::RecordNotFound do
        patch :update, params: { id: other_shopping_list_item.to_param,
                                 format: 'json',
                                 shopping_list_item: { amount: 111 } }
      end
    end
  end
end