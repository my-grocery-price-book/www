require 'ostruct'
require 'faraday'
require 'json'
require 'date'

class PriceEntriesService
  include Enumerable

  def initialize(price_book_page:, region:, logger:)
    @price_book_page = price_book_page
    @region = region
    @logger = logger
  end

  def each
    response = connection.get "/#{@region}/entries", { product_brand_names: @price_book_page.product_names,
                                                       category: @price_book_page.category,
                                                       package_unit: @price_book_page.unit }
    JSON.parse(response.body).each do |entry|
      parsed_entry = OpenStruct.new(date_on: Date.parse(entry['date_on']),
                                    store: entry['store'],
                                    location: entry['location'],
                                    product_name: entry['product_brand_name'],
                                    quantity: entry['quantity'],
                                    package_size: entry['package_size'],
                                    total_price: entry['total_price'],
                                    price_per_package_unit: entry['price_per_package_unit'])
      yield(parsed_entry)
    end
  end

  private

  def connection
    Faraday.new(url: ENV['PUBLIC_API_DOMAIN']) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger, @logger
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end
end
