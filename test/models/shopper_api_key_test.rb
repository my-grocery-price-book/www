# == Schema Information
#
# Table name: shopper_api_keys
#
#  id         :integer          not null, primary key
#  shopper_id :integer          not null
#  api_key    :string           not null
#  api_root   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

describe ShopperApiKey do
  describe '.api_key' do
    it 'returns an existing key when only one shopper_api_key exists' do
      ShopperApiKey.create(shopper_id: 123,
                           api_key: 'hello_api',
                           api_root: 'http://za-wc.example.com/')

      api_key = ShopperApiKey.api_key(shopper_id: 123,
                                      api_root: 'http://za-wc.example.com/',
                                      shopper_email: 'who-cares@example.com')

      api_key.must_equal('hello_api')
    end

    it 'returns an existing key when multiple shopper_api_key exists' do
      ShopperApiKey.create!(shopper_id: 123, api_key: 'before_key', api_root: 'http://za-wc.example.com/')
      ShopperApiKey.create!(shopper_id: 234, api_key: 'correct_key', api_root: 'http://za-wc.example.com/')
      ShopperApiKey.create!(shopper_id: 345, api_key: 'other_key', api_root: 'http://za-ec.example.com/')

      api_key = ShopperApiKey.api_key(shopper_id: 234,
                                      api_root: 'http://za-wc.example.com/',
                                      shopper_email: 'who-cares@example.com')

      api_key.must_equal('correct_key')
    end

    it 'returns an return new key when shopper_api_key does not exist' do
      response_body = '{ "api_key": "my_new_key"}'

      stub_request(:post, 'http://za-wc.example.com/users')
        .with(body: { 'email' => 'test@example.com' })
        .to_return(status: 200, body: response_body)

      api_key = ShopperApiKey.api_key(shopper_id: 123,
                                      api_root: 'http://za-wc.example.com/',
                                      shopper_email: 'test@example.com')

      api_key.must_equal('my_new_key')
    end

    it 'returns an creates new when shopper_api_key does not exist' do
      response_body = '{ "api_key": "my_new_key"}'

      stub_request(:post, 'http://za-wc.example.com/users')
        .with(body: { 'email' => 'test@example.com' })
        .to_return(status: 200, body: response_body)

      ShopperApiKey.api_key(shopper_id: 123, api_root: 'http://za-wc.example.com/', shopper_email: 'test@example.com')

      # must find the key
      ShopperApiKey.find_by!(shopper_id: 123, api_root: 'http://za-wc.example.com/', api_key: 'my_new_key')
    end
  end
end
