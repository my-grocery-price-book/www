require 'integration_helper'

class RegisterAndLoginTest < ActionDispatch::IntegrationTest
  test 'register' do
    visit '/purchases'
    click_link 'Sign up'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: '123asd!@#'
    fill_in 'Password confirmation', with: '123asd!@#'
    click_button 'Sign up'
    assert page.has_content?('This is the home page')
  end

  test 'login' do
    Shopper.create!(email: 'test@example.com', password_confirmation: 'pass123!!', password: 'pass123!!', confirmed_at: Time.current)
    visit '/purchases'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'pass123!!'
    click_button 'Log in'
    assert page.has_content?('Listing Purchases')
  end
end
