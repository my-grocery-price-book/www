require 'test_helper'

class ShoppingListItemPurchasesControllerTest < ActionController::TestCase
  setup do
    @shopper = create_shopper
    @shopping_list = ShoppingList.create!(shopper_id: @shopper.id)
    @shopping_list_item = @shopping_list.items.create!(name: 'Bread')
    sign_in :shopper, @shopper
  end

  context 'POST create' do
    should 'create a item purchase' do
      assert_difference('ShoppingList::ItemPurchase.count') do
        post :create, shopping_list_item_id: @shopping_list_item.id, format: 'json'
      end

      assert_equal(@shopping_list_item.id, ShoppingList::ItemPurchase.last.shopping_list_item_id)
    end
  end
end
