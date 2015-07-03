require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "get show should render successfully when signed in" do
    sign_in :shopper, shoppers(:grant)
    get :show
    assert_response :success
  end

  test "get show should redirect new_shopper_session when signed out" do
    get :show
    assert_redirected_to(new_shopper_session_path)
  end

  test "get edit should render successfully when signed in" do
    sign_in :shopper, shoppers(:grant)
    get :edit
    assert_response :success
  end

  test "get edit should assign shopper when signed in" do
    sign_in :shopper, shoppers(:grant)
    get :edit
    assert_equal assigns[:shopper], shoppers(:grant)
  end

  test "get edit should assign current_public_api_options when signed in" do
    sign_in :shopper, shoppers(:grant)
    get :edit
    assert assigns[:current_public_api_options].kind_of?(Array)
  end

  test "get edit should redirect new_shopper_session when signed out" do
    get :edit
    assert_redirected_to(new_shopper_session_path)
  end

  test "patch update should redirect tprofile_path when signed in" do
    sign_in :shopper, shoppers(:grant)
    patch :update, shopper: {}
    assert_redirected_to(profile_path)
  end

  test "patch update should update shopper current_public_api when signed in" do
    sign_in :shopper, shoppers(:grant)
    patch :update, shopper: {current_public_api: 'za-nw.public-grocery-price-book-api.co.za'}
    shoppers(:grant).reload
    assert_equal 'za-nw.public-grocery-price-book-api.co.za', shoppers(:grant).current_public_api
  end

  test "patch update should redirect new_shopper_session when signed out" do
    patch :update
    assert_redirected_to(new_shopper_session_path)
  end
end
