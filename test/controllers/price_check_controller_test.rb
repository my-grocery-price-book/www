require 'test_helper'

class PriceCheckControllerTest < ActionController::TestCase
  context 'GET index' do
    should 'be success if logged in' do
      sign_in :shopper, create_shopper
      get :index
      assert_response :success
    end

    should 'be success' do
      get :index
      assert_response :success
    end
  end

  context 'GET select_area' do
    should 'be success' do
      get :select_area
      assert_response :success
    end
  end

  context 'POST set_selected_area' do
    should 'redirect to price_check_path' do
      post :set_selected_area
      assert_redirected_to(price_check_path)
    end
  end
end
