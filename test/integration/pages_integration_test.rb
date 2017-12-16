# frozen_string_literal: true

require 'test_helper'

class PagesIntegrationTest < IntegrationTest
  context 'GET /' do
    should 'render' do
      get '/'
      assert_response :success
      assert_includes(response.body, 'My Grocery Price Book')
    end
  end

  context 'GET /contact' do
    should 'render' do
      get '/contact'
      assert_response :success
      assert_includes(response.body, 'Contact')
    end
  end

  context 'GET /thank_you' do
    should 'render' do
      get '/thank_you'
      assert_response :success
      assert_includes(response.body, 'Thank you')
    end
  end
end
