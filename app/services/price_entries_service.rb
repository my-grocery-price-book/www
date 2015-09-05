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
    response = connection.get "/#{@region}/entries", product_brand_names: @price_book_page.product_names,
                                                     category: @price_book_page.category,
                                                     package_unit: @price_book_page.unit
    JSON.parse(response.body).each do |entry|
      yield(parsed_entry(entry))
    end
  end

  private

  def parsed_entry(entry_hash)
    OpenStruct.new(date_on: Date.parse(entry_hash['date_on']),
                   store: entry_hash['store'],
                   location: entry_hash['location'],
                   product_name: entry_hash['product_brand_name'],
                   quantity: entry_hash['quantity'],
                   package_size: entry_hash['package_size'],
                   total_price: entry_hash['total_price'],
                   price_per_package_unit: entry_hash['price_per_package_unit'])
  end

  def connection
    Faraday.new(url: ENV['PUBLIC_API_DOMAIN']) do |faraday|
      faraday.request :url_encoded             # form-encode POST params
      faraday.response :logger, @logger
      faraday.adapter Faraday.default_adapter  # make requests with Net::HTTP
    end
  end
end
