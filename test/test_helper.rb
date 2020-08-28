# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require 'rubygems'
if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.command_name "process_#{ENV['TEST_ENV_NUMBER']}##{Process.pid}"
  SimpleCov.start 'rails' do
    add_filter 'lib/mailer_previews'
  end
  SimpleCov.minimum_coverage_by_file 66
  SimpleCov.minimum_coverage 88
end
require 'bundler/setup'
require 'minitest/spec'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require 'support/load_database_cleaner'
require 'support/factories'
require 'support/match_array'
require 'capybara'
require 'capybara/rails'

require 'webmock/minitest'
WebMock.disable_net_connect!(allow_localhost: true)

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
  self.use_transactional_tests = false
end

class ActionController::TestCase
  def sign_in(shopper, _other = {})
    request.session[:shopper_id] = shopper.id
  end
end

class ActionDispatch::IntegrationTest
  def page
    Capybara::Node::Simple.new(response.body)
  end
end

class IntegrationTest < ActionDispatch::IntegrationTest
  def login_shopper(shopper)
    post '/auth/force_login', params: { id: shopper.id }
  end
end
