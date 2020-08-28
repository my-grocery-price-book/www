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
    visit '/auth/developer' unless current_path.try(:include?, '/auth/developer')
    fill_in 'Email', with: @email
    fill_in 'Name', with: 'Person'
    click_button 'Sign In'
  end

  def add_entry_to_book(name, **entry_details)
    click_link 'Price Book' unless page.has_link?(name)
    click_on name
    click_on 'New Price'

    if page.has_link?('South Africa')
      set_book_region
      create_pick_n_pay_store
    end

    complete_entry(entry_details)
  end

  def complete_entry(store: 'Pick n Pay - Canal Walk', product_name: 'White Sugar',
                     amount: '1', package_size: '410', total_price: '10')
    select store, from: 'Store'
    fill_in 'Product name', with: product_name
    fill_in 'Amount', with: amount
    fill_in 'Package size', with: package_size
    fill_in 'Total price', with: total_price
    click_on 'Save'
  end

  def set_book_region
    click_on 'South Africa'
    select 'Western Cape', from: 'Region'
    click_on 'Save'
  end

  def create_pick_n_pay_store
    click_link 'New Store'
    fill_in 'Name', with: 'Pick n Pay'
    fill_in 'Location', with: 'Canal Walk'
    click_on 'Save'
  end
end

class FeatureTest < ActionDispatch::IntegrationTest
end
