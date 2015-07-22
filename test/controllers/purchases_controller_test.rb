require 'test_helper'

class PurchasesControllerTest < ActionController::TestCase
  setup do
    @shopper = create(:shopper)
    @purchase = create(:purchase, shopper: @shopper)
    sign_in :shopper, @shopper
  end

  context 'GET index' do
    should 'be success' do
      get :index
      assert_response :success
      assert_equal assigns(:purchases), [@purchase]
    end
  end

  context 'GET new' do
    should 'be success' do
      get :new
      assert_response :success
    end
  end

  context 'POST create' do
    should 'create purchase' do
      assert_difference('Purchase.count') do
        post :create, purchase: { location: @purchase.location, purchased_on: @purchase.purchased_on, store: @purchase.store }
      end

      assert_redirected_to purchase_items_path(assigns(:purchase))
    end
  end

  context 'GET edit' do
    should 'be success' do
      get :edit, id: @purchase
      assert_response :success
    end
  end

  context 'PATCH update' do
    should 'update purchase' do
      patch :update, id: @purchase, purchase: { location: @purchase.location, purchased_on: @purchase.purchased_on, store: @purchase.store }
      assert_redirected_to purchase_path(assigns(:purchase))
    end
  end

  context 'DELETE destroy' do
    should 'destroy purchase' do
      assert_difference('Purchase.count', -1) do
        delete :destroy, id: @purchase
      end

      assert_redirected_to purchases_path
    end
  end
end
