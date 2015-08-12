class ShopperApiKey < ActiveRecord::Base
  def self.api_key(shopper:, api_root:)
    shooper_api_key = find_by(shopper_id: shopper.id, api_root: api_root)
    return shooper_api_key.api_key if shooper_api_key
    connection = create_faraday_connection(api_root)
    response = connection.post '/users', email: shopper.email
    response_hash = JSON.parse(response.body)
    create!(shopper_id: shopper.id, api_root: api_root, api_key: response_hash['api_key'])
    response_hash['api_key']
  end

  def self.create_faraday_connection(url)
    Faraday.new(url: url) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger, Rails.logger
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end
end
