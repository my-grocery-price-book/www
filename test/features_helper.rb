# frozen_string_literal: true
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

require 'puma'
Capybara.register_server('puma') do |app, port|
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

  # rubocop:disable Lint/Debugger
  def content_with_screenshot?(*args)
    if content_without_screenshot?(*args)
      true
    else
      save_screenshot
      false
    end
  end

  alias content_without_screenshot? has_content?
  alias has_content? content_with_screenshot?

  def fill_in_with_screenshot(*args)
    fill_in_without_screenshot(*args)
  rescue Capybara::ElementNotFound
    save_screenshot
    raise
  end

  alias fill_in_without_screenshot fill_in
  alias fill_in fill_in_with_screenshot

  def select_with_screenshot(*args)
    select_without_screenshot(*args)
  rescue Capybara::ElementNotFound
    save_screenshot
    raise
  end

  alias select_without_screenshot select
  alias select select_with_screenshot

  def click_link_with_screenshot(*args)
    click_link_without_screenshot(*args)
  rescue Capybara::ElementNotFound
    save_screenshot
    raise
  end

  alias click_link_without_screenshot click_link
  alias click_link click_link_with_screenshot

  def click_on_with_screenshot(*args)
    click_on_without_screenshot(*args)
  rescue Capybara::ElementNotFound
    save_screenshot
    raise
  end

  alias click_on_without_screenshot click_on
  alias click_on click_on_with_screenshot
  # rubocop:enable Lint/Debugger

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

  def click_link_in_email(link_name)
    email = open_email(@email)
    host = Rails.configuration.action_mailer.default_url_options[:host]
    link_path = email.find_link(link_name)[:href].gsub("http://#{host}", '')
    visit link_path
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
