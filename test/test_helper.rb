ENV['RAILS_ENV'] ||= 'test'
require 'rubygems'
require 'simplecov'
require 'bundler/setup'
require 'webmock'
require 'minitest/spec'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'support/load_database_cleaner'
require 'support/factories'
require 'support/match_array'
require 'webmock/minitest'

WebMock.disable_net_connect!(allow_localhost: true)

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
  self.use_transactional_fixtures = false
end

class ActionController::TestCase
  include Devise::TestHelpers
end
