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

  context 'POST create' do
    should 'create purchase' do
      assert_difference('Purchase.count') do
        post :create
      end

      assert_redirected_to edit_purchase_path(assigns(:purchase))
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
      assert_redirected_to edit_purchase_path(assigns(:purchase))
    end
  end

  context 'PATCH complete' do
    setup do
      create(:shopper_api_key,
             shopper_id: @shopper.id,
             api_url: PublicApi.find_by_code(@shopper.current_public_api).url,
             api_key: 'test')
      stub_request(:post, "http://red.vagrant/entries")
    end

    should 'redirect to profile if no current_public_api' do
      @shopper.update_column(:current_public_api,'')
      patch :complete, id: @purchase
      assert_redirected_to edit_profile_path
    end

    should 'redirect to edit_purchase_path' do
      patch :complete, id: @purchase
      assert_redirected_to edit_purchase_path(assigns(:purchase))
    end

    should 'mark purchase complete' do
      create(:purchase_item, purchase_id: @purchase.id)

      patch :complete, id: @purchase
      @purchase.reload

      refute_nil(@purchase.completed_at)
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
