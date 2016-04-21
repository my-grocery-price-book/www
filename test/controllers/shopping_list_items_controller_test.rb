require 'test_helper'

class ShoppingListItemsControllerTest < ActionController::TestCase
  setup do
    @shopper = create_shopper
    @price_book = PriceBook.create!(shopper: @shopper)
    @shopping_list = ShoppingList.create!(price_book_id: @price_book.id)
    sign_in :shopper, @shopper
  end

  context 'GET index' do
    should 'be success' do
      get :index, shopping_list_id: @shopping_list.to_param
      assert_response :success
    end
  end

  context 'GET latest' do
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

  context 'POST create' do
    setup do
      @item_params = { 'name' => 'Test', 'amount' => 123, 'unit' => 'ml' }
    end

    should 'create shopping_list_item' do
      assert_difference('ShoppingList::Item.count') do
        post :create, shopping_list_id: @shopping_list.to_param, shopping_list_item: @item_params
      end

      saved_params = ShoppingList::Item.last.attributes.slice('name', 'amount', 'unit')
      assert_equal(saved_params, @item_params)
    end

    should 'set shopping_list' do
      post :create, shopping_list_id: @shopping_list.to_param, shopping_list_item: @item_params
      assert_equal(@shopping_list.id, ShoppingList::Item.last.shopping_list_id)
    end

    should 'redirect to shopping_list_path' do
      post :create, shopping_list_id: @shopping_list.to_param, shopping_list_item: @item_params
      assert_redirected_to shopping_list_items_path(@shopping_list)
    end

    should 'raise error if shopping_list does not exist' do
      assert_raise ActiveRecord::RecordNotFound do
        post :create, shopping_list_id: 'sa11', shopping_list_item: @item_params
      end
    end

    should 'raise error if shopping_list belong to another shopper' do
      other_shopping_list = ShoppingList.create!(shopper: create_shopper)
      assert_raise ActiveRecord::RecordNotFound do
        post :create, shopping_list_id: other_shopping_list.to_param, shopping_list_item: @item_params
      end
    end
  end

  context 'DELETE destroy' do
    setup do
      @shopping_list_item = @shopping_list.items.create!
    end

    should 'deletes the item' do
      delete :destroy, id: @shopping_list_item.to_param

      assert_raise ActiveRecord::RecordNotFound do
        @shopping_list_item.reload
      end
    end

    should 'redirect to shopping_list_path' do
      delete :destroy, id: @shopping_list_item.to_param
      assert_redirected_to shopping_list_items_path(@shopping_list)
    end

    should 'be success for json format' do
      delete :destroy, id: @shopping_list_item.to_param, format: 'json'
      assert_response :success
    end

    should 'raise error if shopping_list_item does not exist' do
      assert_raise ActiveRecord::RecordNotFound do
        delete :destroy, id: 'asdasd'
      end
    end

    should 'raise error if shopping_list item belong to another shopper' do
      other_shopping_list = ShoppingList.create!(shopper: create_shopper)
      other_shopping_list_item = other_shopping_list.items.create!
      assert_raise ActiveRecord::RecordNotFound do
        delete :destroy, id: other_shopping_list_item.to_param
      end
    end
  end
end
