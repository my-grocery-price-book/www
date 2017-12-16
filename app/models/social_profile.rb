# frozen_string_literal: true

require 'faraday'

class SocialProfile
  class OneAllReponse
    def initialize(raw_response)
      @response = MultiJson.load(raw_response.body).fetch('response')
    end

    def success?
      @response.dig('request', 'status', 'code') == 200
    end

    def email
      emails = identity['emails'] || [{}]
      emails.first['value']
    end

    def provider
      identity['provider']
    end

    private

    def identity
      @response.dig('result', 'data', 'user', 'identity')
    end
  end

  attr_reader :authenticated
  attr_reader :email
  attr_reader :provider

  def initialize(token)
    response = oneall_token_response(token)
    parse_response(OneAllReponse.new(response))
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

  # @param [OneAllReponse] response
  def parse_response(response)
    if response.success?
      @email = response.email
      @provider = response.provider
      @authenticated = true
    else
      @authenticated = false
      Rollbar.warn('Authentication Failed', response: response)
    end
  end

  public

  # @return [true,false]
  def authenticated?
    authenticated
  end
end
