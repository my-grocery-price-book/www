require 'spec_helper'
require 'grocery_api_service'

describe GroceryApiService do
  let(:http_mock) { HTTPMock.new }
  subject { GroceryApiService.new('http://www.example.com', http_mock) }

  describe 'product_brand_names' do
    it 'loads product_brand_names' do
      http_mock.ok_response('http://www.example.com/product_brand_names', ['result'])
      subject.product_brand_names do |product_brand_names|
        expect(product_brand_names).to eq(['result'])
      end
    end

    it 'returns nil on failure' do
      http_mock.failed_response('http://www.example.com/product_brand_names')
      subject.product_brand_names do |product_brand_names|
        expect(product_brand_names).to be_nil
      end
    end
  end

  describe 'location_names' do
    it 'loads location_names' do
      http_mock.ok_response('http://www.example.com/location_names', ['1'])
      subject.location_names do |location_names|
        expect(location_names).to eq(['1'])
      end
    end

    it 'returns nil on failure' do
      http_mock.failed_response('http://www.example.com/location_names')
      subject.location_names do |location_names|
        expect(location_names).to be_nil
      end
    end
  end

  describe 'store_names' do
    it 'loads store_names' do
      http_mock.ok_response('http://www.example.com/store_names', ['2'])
      subject.store_names do |store_names|
        expect(store_names).to eq(['2'])
      end
    end

    it 'returns nil on failure' do
      http_mock.failed_response('http://www.example.com/store_names')
      subject.store_names do |store_names|
        expect(store_names).to be_nil
      end
    end
  end

  describe 'product_summaries' do
    it 'loads products' do
      http_mock.ok_response('http://www.example.com/products?q=1', ['q'])
      subject.product_summaries('q=1') do |products|
        expect(products).to eq(['q'])
      end
    end

    it 'returns nil on failure' do
      http_mock.failed_response('http://www.example.com/products?q=1')
      subject.product_summaries('q=1') do |products|
        expect(products).to be_nil
      end
    end
  end
end
