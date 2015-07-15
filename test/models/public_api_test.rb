require 'test_helper'

describe PublicApi do
  describe 'first_code' do
    it 'gives za-ec' do
      PublicApi.first_code.must_equal 'za-ec'
    end
  end

  describe 'all' do
    it 'loads all' do
      all = PublicApi.all.map{|public_api| [public_api.name, public_api.url] }
      all.must_equal(
        [
          ['Eastern Cape', 'za-ec.public-grocery-price-book-api.co.za'],
          ['Free State', 'za-fs.public-grocery-price-book-api.co.za'],
          ['Gauteng','za-gt.public-grocery-price-book-api.co.za'],
          ['KwaZulu-Natal', 'za-nl.public-grocery-price-book-api.co.za'],
          ['Limpopo', 'za-lp.public-grocery-price-book-api.co.za'],
          ['Mpumalanga', 'za-mp.public-grocery-price-book-api.co.za'],
          ['Northern Cape', 'za-nc.public-grocery-price-book-api.co.za'],
          ['North West', 'za-nw.public-grocery-price-book-api.co.za'],
          ['Western Cape', 'za-wc.public-grocery-price-book-api.co.za']
        ]
      )
    end
  end
end
