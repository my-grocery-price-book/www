# frozen_string_literal: true

require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  context 'GET show' do
    should 'render successfully when signed in' do
      sign_in create_shopper, scope: :shopper
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
      sign_in create_shopper, scope: :shopper
      get :edit
      assert_response :success
    end

    should 'assign shopper when signed in' do
      shopper = create_shopper
      sign_in shopper, scope: :shopper
      get :edit
      assert_equal assigns[:shopper], shopper
    end

    should 'redirect new_shopper_session when signed out' do
      get :edit
      assert_redirected_to(new_shopper_session_path)
    end
  end

  context 'PATCH update' do
    should 'redirect profile_path when signed in' do
      sign_in create_shopper, scope: :shopper
      patch :update, params: { shopper: {} }
      assert_redirected_to(profile_path)
    end

    should 'redirect new_shopper_session when signed out' do
      patch :update
      assert_redirected_to(new_shopper_session_path)
    end
  end
end
