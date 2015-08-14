require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  context 'GET show' do
    should 'render successfully when signed in' do
      sign_in :shopper, create(:shopper)
      get :show
      assert_response :success
    end

    should 'redirect new_shopper_session when signed out' do
      get :show
      assert_redirected_to(new_shopper_session_path)
    end
  end

  context 'GET edit' do
    should 'should render successfully when signed in' do
      sign_in :shopper, create(:shopper)
      get :edit
      assert_response :success
    end

    should 'assign shopper when signed in' do
      shopper = create(:shopper)
      sign_in :shopper, shopper
      get :edit
      assert_equal assigns[:shopper], shopper
    end

    should 'assign current_public_api_options when signed in' do
      sign_in :shopper, create(:shopper)
      get :edit
      assert_equal(PublicApi.all, assigns[:public_apis])
    end

    should 'redirect new_shopper_session when signed out' do
      get :edit
      assert_redirected_to(new_shopper_session_path)
    end
  end

  context 'PATCH update' do
    should 'redirect tprofile_path when signed in' do
      sign_in :shopper, create(:shopper)
      patch :update, shopper: {}
      assert_redirected_to(profile_path)
    end

    should 'update shopper current_public_api when signed in' do
      shopper = create(:shopper)
      sign_in :shopper, shopper
      patch :update, shopper: { current_public_api: 'za-nw.public-grocery-price-book-api.co.za' }
      shopper.reload
      assert_equal 'za-nw.public-grocery-price-book-api.co.za', shopper.current_public_api
    end

    should 'redirect new_shopper_session when signed out' do
      patch :update
      assert_redirected_to(new_shopper_session_path)
    end
  end
end
