require 'test_helper'

describe PriceEntriesService do
  describe 'each' do
    def default_values
      { date_on: Time.zone.today, store: 'Spar', location: 'Edgemead', product_name: 'Coke Lite',
        quantity: 1, package_size: 340.0, total_price: 13.99, price_per_package_unit: 1 }
    end

    def default_api_values
      { date_on: Time.zone.today, store: 'Spar', location: 'Edgemead', product_brand_name: 'Coke Lite',
        quantity: 1, package_size: 340.0, total_price: 13.99, price_per_package_unit: 1,
        region: 'ZA-WC', category: 'Soda', unit: 'L' }
    end

    it 'loads 1 price entry' do
      api_entries_values = [default_api_values]

      stub_request(:get, 'https://api.example.com/ZA-WC/entries?category=Soda&package_unit=L&product_brand_names%5B%5D=Coke%20Lite')
        .to_return(status: 200, body: api_entries_values.to_json)
      price_book_page = PriceBook::Page.new(product_names: ['Coke Lite'], category: 'Soda', unit: 'L')
      prices_service = PriceEntriesService.new(price_book_page: price_book_page,
                                               region: 'ZA-WC', logger: Rails.logger)

      entries_values = [default_values]
      entries = entries_values.map { |entry_values| OpenStruct.new(entry_values) }
      prices_service.entries.must_equal(entries)
    end

    it 'loads many price entry' do
      api_entries_values = [default_api_values, default_api_values.merge(product_brand_name: 'Fanta')]

      stub_request(:get, 'https://api.example.com/ZA-WC/entries?category=Soda&package_unit=L&product_brand_names%5B%5D=Coke%20Lite&product_brand_names%5B%5D=Fanta')
        .to_return(status: 200, body: api_entries_values.to_json)
      price_book_page = PriceBook::Page.new(product_names: ['Coke Lite', 'Fanta'], category: 'Soda', unit: 'L')
      prices_service = PriceEntriesService.new(price_book_page: price_book_page,
                                               region: 'ZA-WC', logger: Rails.logger)

      entries_values = [default_values, default_values.merge(product_name: 'Fanta')]
      entries = entries_values.map { |entry_values| OpenStruct.new(entry_values) }
      prices_service.entries.must_equal(entries)
    end

    it 'loads many price entry for another region' do
      api_entries_values = [default_api_values, default_api_values]

      stub_request(:get, 'https://api.example.com/ZA-EC/entries?category=Soda&package_unit=L&product_brand_names%5B%5D=Coke%20Lite&product_brand_names%5B%5D=Fanta')
        .to_return(status: 200, body: api_entries_values.to_json)
      price_book_page = PriceBook::Page.new(product_names: ['Coke Lite', 'Fanta'], category: 'Soda', unit: 'L')
      prices_service = PriceEntriesService.new(price_book_page: price_book_page,
                                               region: 'ZA-EC', logger: Rails.logger)

      entries_values = [default_values, default_values]
      entries = entries_values.map { |entry_values| OpenStruct.new(entry_values) }
      prices_service.entries.must_equal(entries)
    end
  end
end
