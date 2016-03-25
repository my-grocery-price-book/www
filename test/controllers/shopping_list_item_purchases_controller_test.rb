require 'test_helper'

class ShoppingListItemPurchasesControllerTest < ActionController::TestCase
  setup do
    @shopper = create_shopper
    @shopping_list = ShoppingList.create!(shopper: @shopper)
    @shopping_list_item = @shopping_list.items.create!(name: 'Bread')
    sign_in :shopper, @shopper
  end

  context 'POST create' do
    should 'create a item purchase' do
      assert_difference('ShoppingList::ItemPurchase.count') do
        post :create, shopping_list_item_id: @shopping_list_item.id, format: 'json'
      end

      assert_equal(@shopping_list_item.id, ShoppingList::ItemPurchase.last.shopping_list_item_id)
      assert_not_nil(@shopping_list_item.purchased_at)
    end

    should 'redirect to shopping list items for html format' do
      post :create, shopping_list_item_id: @shopping_list_item.id
      assert_redirected_to shopping_list_items_path(@shopping_list)
    end

    should 'redirect to shopping list items for html format with multiple items' do
      shopping_list_item2 = @shopping_list.items.create!(name: 'Bread')
      post :create, shopping_list_item_id: shopping_list_item2.id
      assert_redirected_to shopping_list_items_path(@shopping_list)
    end

    should 'be success for json format' do
      post :create, shopping_list_item_id: @shopping_list_item.id, format: 'json'
      assert_response :success
    end
  end

  context 'DELETE destroy' do
    setup do
      @shopping_list_item.create_purchase
    end

    should 'destroys a item purchase' do
      assert_difference('ShoppingList::ItemPurchase.count', -1) do
        delete :destroy, shopping_list_item_id: @shopping_list_item.id, format: 'json'
      end

      @shopping_list_item.reload
      assert_nil(@shopping_list_item.purchased_at)
    end

    should 'redirect to shopping list items for html format' do
      delete :destroy, shopping_list_item_id: @shopping_list_item.id
      assert_redirected_to shopping_list_items_path(@shopping_list)
    end

    should 'redirect to shopping list items for html format with multiple items' do
      shopping_list_item2 = @shopping_list.items.create!(name: 'Bread')
      shopping_list_item2.create_purchase
      delete :destroy, shopping_list_item_id: shopping_list_item2.id
      assert_redirected_to shopping_list_items_path(@shopping_list)
    end

    should 'be success for json format' do
      delete :destroy, shopping_list_item_id: @shopping_list_item.id, format: 'json'
      assert_response :success
      assert_equal({ 'data' => { 'purchased_at' => nil } }, JSON.parse(response.body))
    end
  end
end
