require 'spec_helper'
require 'grocery_api_service'

describe GroceryApiService do
  subject {GroceryApiService.new('http://za-fs.public-grocery-price-book-api.co.za/')}

  describe 'product_brand_names' do
    async 'loads product_brand_names' do
      subject.product_brand_names do |product_brand_names|
        run_async {
          expect(product_brand_names).to_not be_empty
        }
      end
    end

    async 'product_brand_names returns nil on failure' do
      subject.host_url = nil
      subject.product_brand_names do |product_brand_names|
        run_async {
          expect(product_brand_names).to be_nil
        }
      end
    end
  end

  describe 'location_names' do
    async 'loads location_names' do
      subject.location_names do |location_names|
        run_async {
          expect(location_names).to_not be_empty
        }
      end
    end

    async 'location_names returns nil on failure' do
      subject.host_url = nil
      subject.location_names do |location_names|
        run_async {
          expect(location_names).to be_nil
        }
      end
    end
  end

  describe 'store_names' do
    async 'loads store_names' do
      subject.store_names do |store_names|
        run_async {
          expect(store_names).to_not be_empty
        }
      end
    end

    async 'store_names returns nil on failure' do
      subject.host_url = nil
      subject.store_names do |store_names|
        run_async {
          expect(store_names).to be_nil
        }
      end
    end
  end
end
