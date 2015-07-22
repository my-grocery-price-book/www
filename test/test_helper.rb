ENV['RAILS_ENV'] ||= 'test'
require 'rubygems'
require 'bundler/setup'
require 'simplecov'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'support/load_database_cleaner'
require 'support/load_factory_girl'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL # Make the Capybara DSL available in all integration tests
end
