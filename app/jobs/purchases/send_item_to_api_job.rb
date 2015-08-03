require 'faraday'

class Purchases::SendItemToApiJob < ActiveJob::Base
  queue_as :default

  def perform(api_url:, api_key:, date_on:, store:, location:, item:)
    connection = create_faraday_connection(api_url)
    connection.post '/entries',
                    api_key: api_key,
                    product_brand_name: item.product_brand_name,
                    generic_name: item.regular_name,
                    category: item.category,
                    package_size: item.package_size,
                    package_unit: item.package_unit,
                    quantity: item.quantity,
                    total_price: item.total_price,
                    date_on: date_on,
                    store: store,
                    location: location
  end

  private

  def create_faraday_connection(url)
    Faraday.new(url: url) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger, Rails.logger
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end
end
