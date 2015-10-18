require 'test_helper'

class PriceCheckControllerTest < ActionController::TestCase
  context 'GET index' do
    should 'redirect_to select_area when no current_public_api cookie set' do
      get :index
      assert_redirected_to(select_area_path)
    end

    should 'be success if logged in' do
      sign_in :shopper, create_shopper(current_public_api: PublicApi.first_code)
      get :index
      assert_response :success
    end

    should 'redirect_to edit_profile when logged in and no current_public_api set' do
      sign_in :shopper, create_shopper(current_public_api: '')
      get :index
      assert_redirected_to(edit_profile_path)
    end

    should 'be success' do
      session['current_public_api_code'] = PublicApi.first_code
      get :index
      assert_response :success
    end

    should 'redirect_to select_area when gabarge current_public_api cookie set' do
      cookies['current_public_api'] = 'asdasdasd'
      get :index
      assert_redirected_to(select_area_path)
    end
  end

  context 'GET select_area' do
    should 'be success' do
      get :select_area
      assert_response :success
    end

    should 'be assign @public_apis' do
      get :select_area
      assert_equal(PublicApi.all, assigns(:public_apis))
    end
  end

  context 'POST set_selected_area' do
    should 'be set current_public_api_code session' do
      post :set_selected_area, current_public_api: PublicApi.first_code
      assert_equal(PublicApi.first_code, session[:current_public_api_code])
    end

    should 'redirect to price_check_path' do
      post :set_selected_area
      assert_redirected_to(price_check_path)
    end
  end
end
