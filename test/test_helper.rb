# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require 'rubygems'
if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start 'rails'
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
  include Devise::Test::ControllerHelpers
end

class ActionDispatch::IntegrationTest
  def page
    Capybara::Node::Simple.new(response.body)
  end
end

class IntegrationTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  teardown do
    Warden.test_reset!
  end

  setup do
    Warden.test_mode!
  end

  def login_shopper(shopper)
    login_as(shopper, scope: :shopper)
  end
end
