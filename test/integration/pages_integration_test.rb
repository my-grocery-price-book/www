# == Schema Information
#
# Table name: invites
#
#  id            :integer          not null, primary key
#  price_book_id :integer
#  name          :string
#  email         :string
#  status        :string           default("sent"), not null
#  token         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class PagesIntegrationTest < ActionDispatch::IntegrationTest
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
