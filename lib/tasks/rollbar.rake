# frozen_string_literal: true
namespace :rollbar do
  desc 'Send the deployment notification to Rollbar.'
  task :deploy do
    require 'net/http'
    require 'oj'
    require 'multi_json'

    uri    = URI.parse 'https://api.rollbar.com/api/1/deploy/'
    params = {
      local_username: ENV['LOCAL_USER'] || ENV['USER'] || ENV['USERNAME'],
      access_token: ENV['ROLLBAR_ACCESS_TOKEN'],
      environment: ENV['ROLLBAR_ENV'],
      revision: ENV['REVISION']
    }

    request      = Net::HTTP::Post.new(uri.request_uri)
    request.body = MultiJson.dump(params)

    begin
      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      puts 'Rollbar notification complete.'
    rescue Net::OpenTimeout => e
      puts "Rollbar notification failed: #{e.message}"
    end
  end
end
