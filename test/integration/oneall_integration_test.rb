# frozen_string_literal: true

require 'test_helper'

class OneallIntegrationTest < IntegrationTest
  context 'POST /callmeback/oneall' do
    context 'success' do
      setup do
        @token = 'mytoken'
        stub_url = "https://#{ENV['ONE_ALL_SUBDOMAIN']}.api.oneall.com/connections/#{@token}.json"
        stub_request(:get, stub_url)
          .to_return(status: 200, headers: {},
                     body: File.read("#{Rails.root}/test/fixtures/oneall_facebook_response.json"))
      end

      should 'redirect to book' do
        post '/callmeback/oneall', params: { connection_token: @token }
        assert_redirected_to(book_pages_path(PriceBook.first))
      end

      should 'set flash notice' do
        post '/callmeback/oneall', params: { connection_token: @token }
        assert_equal 'Successfully logged in', flash[:notice]
      end

      should 'sign in user' do
        post '/callmeback/oneall', params: { connection_token: @token }
        assert_not_nil controller.current_shopper
      end
    end

    context 'failed' do
      setup do
        @token = 'mytoken'
        stub_url = "https://#{ENV['ONE_ALL_SUBDOMAIN']}.api.oneall.com/connections/#{@token}.json"
        stub_request(:get, stub_url)
          .to_return(status: 404, headers: {},
                     body: File.read("#{Rails.root}/test/fixtures/oneall_404_response.json"))
      end

      should 'redirect to new_shopper_session_path' do
        post '/callmeback/oneall', params: { connection_token: @token }
        assert_redirected_to(new_shopper_session_path)
      end

      should 'set not_flash notice' do
        post '/callmeback/oneall', params: { connection_token: @token }
        assert_nil flash[:notice]
      end

      should 'set flash alert' do
        post '/callmeback/oneall', params: { connection_token: @token }
        assert_equal 'Log in failed', flash[:alert]
      end

      should 'should not sign in user' do
        post '/callmeback/oneall', params: { connection_token: @token }
        assert_nil controller.current_shopper
      end
    end
  end
end
