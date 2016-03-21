require 'test_helper'

class GuestControllerTest < ActionController::TestCase
  context 'POST login' do
    should 'create a shopper' do
      assert_difference('Shopper.count') do
        post :login
      end

      assert_redirected_to root_path
    end
  end
end
