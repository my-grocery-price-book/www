# frozen_string_literal: true

require 'test_helper'

class GuestControllerTest < ActionController::TestCase
  context 'POST login' do
    should 'create a shopper' do
      assert_difference('Shopper.count') do
        post :login
      end

      assert Shopper.last.guest?
    end

    should 'redirect to shopper_login_path' do
      post :login

      assert_redirected_to price_book_pages_path
    end
  end
end
