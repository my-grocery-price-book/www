require 'test_helper'
require 'capybara'
require 'capybara/rails'
require 'capybara/poltergeist'
require 'capybara/email'

require 'phantomjs'
Phantomjs.path # install phantomjs
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, phantomjs: Phantomjs.path)
end

Capybara.default_driver = :poltergeist

require "puma"
Capybara.register_server("puma") do |app, port|
  server = Puma::Server.new(app)
  server.add_tcp_listener(Capybara.server_host, port)
  server.run
end

class PersonaSession
  include Capybara::DSL
  include Capybara::Email::DSL

  # override to stop usage of global current_session
  def page
    @page ||= Capybara::Session.new(Capybara.current_driver, Capybara.app)
  end

  def click_link_in_email(link_name)
    email = open_email(@email)
    host = Rails.configuration.action_mailer.default_url_options[:host]
    link_path = email.find_link(link_name)[:href].gsub("http://#{host}", '')
    visit link_path
  end

  def has_content_with_screenshot?(*args)
    if has_content_without_screenshot?(*args)
      true
    else
      save_screenshot
      false
    end
  end

  alias_method :has_content_without_screenshot?, :has_content?
  alias_method :has_content?, :has_content_with_screenshot?

  def perform(&block)
    instance_exec(&block)
  end
end

class ShopperPersonaSession < PersonaSession
  def initialize(email: nil)
    super()
    @email = email
    @password = 'password'
  end

  def sign_up
    visit '/shoppers/sign_up' unless current_path.try(:include?, '/shoppers/sign_up')
    fill_in 'Email', with: @email
    fill_in 'Password', with: @password
    fill_in 'Password confirmation', with: @password
    click_button 'Sign up'
  end
end

class FeatureTest < ActionDispatch::IntegrationTest
end
