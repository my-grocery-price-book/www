require 'test_helper'

class ShoppingListItemsControllerTest < ActionController::TestCase
  setup do
    @shopper = create_shopper
    @shopping_list = ShoppingList.create!(shopper: @shopper)
    sign_in :shopper, @shopper
  end

  context 'GET index' do
    should 'be success' do
      get :index, shopping_list_id: @shopping_list.to_param
      assert_response :success
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
      other_shopping_list = ShoppingList.create!(shopper_id: 44)
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
      delete :destroy, id: @shopping_list_item.to_param, shopping_list_id: @shopping_list.to_param

      assert_raise ActiveRecord::RecordNotFound do
        @shopping_list_item.reload
      end
    end

    should 'redirect to shopping_list_path' do
      delete :destroy, id: @shopping_list_item.to_param, shopping_list_id: @shopping_list.to_param
      assert_redirected_to shopping_list_path(@shopping_list)
    end

    should 'raise error if shopping_list_item does not exist' do
      assert_raise ActiveRecord::RecordNotFound do
        delete :destroy, id: 'asdasd', shopping_list_id: @shopping_list.to_param
      end
    end

    should 'raise error if shopping_list does not exist' do
      assert_raise ActiveRecord::RecordNotFound do
        delete :destroy, id: @shopping_list_item.to_param, shopping_list_id: 'asdasdas'
      end
    end

    should 'raise error if shopping_list belong to another shopper' do
      other_shopping_list = ShoppingList.create!(shopper_id: 77)
      assert_raise ActiveRecord::RecordNotFound do
        delete :destroy, id: @shopping_list_item.to_param, shopping_list_id: other_shopping_list.to_param
      end
    end
  end
end
