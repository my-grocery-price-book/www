require 'faraday'

class SocialProfile
  def initialize(token)
    response = oneall_token_response(token)
    parse_response(response)
  end

  private

  def oneall_token_response(token)
    conn = Faraday.new(url: "https://#{ENV['ONE_ALL_SUBDOMAIN']}.api.oneall.com") do |faraday|
      faraday.request :url_encoded
      faraday.response :logger, Rails.logger, bodies: true
      faraday.adapter Faraday.default_adapter
    end
    conn.basic_auth(ENV['ONE_ALL_PUBLIC_KEY'], ENV['ONE_ALL_PRIVATE_KEY'])
    conn.get("/connections/#{token}.json")
  end

  def parse_response(response)
    response = MultiJson.load(response.body).fetch('response')
    @authenticated = response.dig('request', 'status', 'code') == 200
    if @authenticated
      @identity = response.dig('result', 'data', 'user', 'identity')
    else
      Rollbar.warn('Authentication Failed', response: response)
    end
  end

  public

  # @return [true,false]
  def authenticated?
    @authenticated
  end

  # @return [String]
  def email
    emails = @identity['emails'] || [{}]
    emails.first['value']
  end

  # @return [Provider]
  def provider
    @identity['provider']
  end
end
