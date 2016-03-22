require 'test_helper'
require 'capybara'
require 'capybara/rails'
require 'capybara/poltergeist'

Capybara.default_driver = :poltergeist

class ActionDispatch::IntegrationTest
  include Capybara::DSL # Make the Capybara DSL available in all integration tests

  def sign_in_shopper(shopper_attributes = {})
    shopper ||= Shopper.create!({ email: 'test@example.com',
                                  password_confirmation: 'pass123!!',
                                  password: 'pass123!!',
                                  confirmed_at: Time.current }.merge(shopper_attributes))
    fill_in 'Email', with: shopper.email
    fill_in 'Password', with: shopper.password
    click_button 'Log in'
    shopper
  end

  def sign_in_guest
    click_button 'Log in as Guest'
  end
end
