require 'test_helper'

class ActionDispatch::IntegrationTest
  include Capybara::DSL # Make the Capybara DSL available in all integration tests

  def sign_in_shopper(shopper = nil)
    shopper ||= Shopper.create!(email: 'test@example.com', password_confirmation: 'pass123!!', password: 'pass123!!', confirmed_at: Time.current)
    fill_in 'Email', with: shopper.email
    fill_in 'Password', with: shopper.password
    click_button 'Log in'
    shopper
  end
end


