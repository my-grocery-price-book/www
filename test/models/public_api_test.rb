require 'test_helper'

describe PublicApi do
  describe 'first_code' do
    it 'gives Red code of 1' do
      PublicApi.first_code.must_equal '1'
    end
  end

  describe 'all' do
    it 'loads all' do
      all = PublicApi.all.map{|public_api| [public_api.name, public_api.url] }
      all.must_equal(
        [
          ['Red', 'http://red.vagrant'],
          ['Green', 'http://green.vagrant'],
          ['Blue','http://blue.vagrant']
        ]
      )
    end
  end
end
