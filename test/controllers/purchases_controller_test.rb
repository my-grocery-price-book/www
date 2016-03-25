# == Schema Information
#
# Table name: purchases
#
#  id           :integer          not null, primary key
#  purchased_on :date
#  store        :string
#  location     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  shopper_id   :integer
#  completed_at :datetime
#

require 'test_helper'

class PurchasesControllerTest < ActionController::TestCase
  setup do
    @shopper = create_shopper
    @purchase = Purchase.create!(shopper: @shopper, purchased_on: (Time.zone.today - 1))
    sign_in :shopper, @shopper
  end

  context 'GET index' do
    should 'be success' do
      get :index
      assert_response :success
      assert_equal assigns(:purchases), [@purchase]
    end

    should 'be ordered by purchased_on in descending order' do
      purchase_2 = Purchase.create!(shopper: @shopper, purchased_on: Time.zone.today)
      get :index
      assert_equal assigns(:purchases), [purchase_2, @purchase]
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
      patch :update, id: @purchase,
                     purchase: { location: @purchase.location,
                                 purchased_on: @purchase.purchased_on,
                                 store: @purchase.store }
      assert_redirected_to edit_purchase_path(assigns(:purchase))
    end
  end

  context 'PATCH complete' do
    setup do
      api = PublicApi.all.first
      @shopper.update_column(:current_public_api, api.code)
      ShopperApiKey.create!(shopper_id: @shopper.id, api_root: api.url_root, api_key: 'test')
      stub_request(:post, "https://api.example.com/#{api.code}/entries")
    end

    should 'redirect to profile if no current_public_api' do
      @shopper.update_column(:current_public_api, '')
      patch :complete, id: @purchase
      assert_redirected_to edit_profile_path
    end

    should 'redirect to edit_purchase_path' do
      patch :complete, id: @purchase
      assert_redirected_to edit_purchase_path(assigns(:purchase))
    end

    should 'mark purchase complete' do
      @purchase.items.create

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
