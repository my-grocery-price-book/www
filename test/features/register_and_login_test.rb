require 'integration_helper'

class RegisterAndLoginTest < IntegrationTest
  test 'register' do
    visit '/purchases'
    click_link 'Sign up'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: '123asd!@#'
    fill_in 'Password confirmation', with: '123asd!@#'
    click_button 'Sign up'
    assert page.has_content?('Welcome! You have signed up successfully.')
  end

  test 'login' do
    Shopper.create!(email: 'test@example.com',
                    password_confirmation: 'pass123!!',
                    password: 'pass123!!',
                    confirmed_at: Time.current)
    visit '/purchases'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'pass123!!'
    click_button 'Log in'
    assert page.has_content?('Listing Purchases')
  end

  test 'guest register' do
    visit '/purchases'
    click_on 'Log in as Guest'
    click_link 'Register'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: '123asd!@#'
    fill_in 'Password confirmation', with: '123asd!@#'
    click_button 'Register'
    assert page.has_content?('You have registered successfully.')
  end
end
