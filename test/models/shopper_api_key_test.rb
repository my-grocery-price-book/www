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
      shopper = create(:shopper)
      create(:shopper_api_key, shopper_id: shopper.id,
                               api_key: 'hello_api', api_root: 'http://za-wc.example.com/')

      api_key = ShopperApiKey.api_key(shopper: shopper, api_root: 'http://za-wc.example.com/')

      api_key.must_equal('hello_api')
    end

    it 'returns an existing key when multiple shopper_api_key exists' do
      shopper = create(:shopper)
      create(:shopper_api_key, shopper_id: create(:shopper).id,
                               api_key: 'before_key', api_root: 'http://za-wc.example.com/')
      create(:shopper_api_key, shopper_id: shopper.id,
                               api_key: 'correct_key', api_root: 'http://za-wc.example.com/')
      create(:shopper_api_key, shopper_id: create(:shopper).id,
                               api_key: 'other_key', api_root: 'http://za-ec.example.com/')

      api_key = ShopperApiKey.api_key(shopper: shopper, api_root: 'http://za-wc.example.com/')

      api_key.must_equal('correct_key')
    end

    it 'returns an return new key when shopper_api_key does not exist' do
      response_body = '{ "api_key": "my_new_key"}'

      shopper = create(:shopper, email: 'test@example.com')
      stub_request(:post, 'http://za-wc.example.com/users')
        .with(body: { 'email' => shopper.email })
        .to_return(status: 200, body: response_body)

      api_key = ShopperApiKey.api_key(shopper: shopper, api_root: 'http://za-wc.example.com/')

      api_key.must_equal('my_new_key')
      ShopperApiKey.find_by(shopper_id: shopper.id,
                            api_root: 'http://za-wc.example.com/',
                            api_key: api_key)
    end

    it 'returns an return creates new when shopper_api_key does not exist' do
      response_body = '{ "api_key": "my_new_key"}'

      shopper = create(:shopper, email: 'test@example.com')
      stub_request(:post, 'http://za-wc.example.com/users')
        .with(body: { 'email' => shopper.email })
        .to_return(status: 200, body: response_body)

      ShopperApiKey.api_key(shopper: shopper, api_root: 'http://za-wc.example.com/')

      ShopperApiKey.find_by(shopper_id: shopper.id,
                            api_root: 'http://za-wc.example.com/',
                            api_key: 'my_new_key').wont_be_nil
    end
  end
end
