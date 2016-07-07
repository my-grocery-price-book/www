require 'features_helper'

class RegisterAndLoginTest < FeatureTest
  test 'login' do
    Shopper.create!(email: 'test@example.com',
                    password_confirmation: 'pass123!!',
                    password: 'pass123!!',
                    confirmed_at: Time.current)
    shopper = ShopperPersonaSession.new
    shopper.visit '/shopping_lists'
    shopper.fill_in 'Email', with: 'test@example.com'
    shopper.fill_in 'Password', with: 'pass123!!'
    shopper.click_button 'Log in'
    assert shopper.has_content?('Shopping Lists')
  end

  test 'guest register' do
    shopper = ShopperPersonaSession.new
    shopper.visit '/shopping_lists'
    shopper.click_on 'Log in as Guest'
    shopper.click_link 'Register'
    shopper.fill_in 'Email', with: 'test@example.com'
    shopper.fill_in 'Password', with: '123asd!@#'
    shopper.fill_in 'Password confirmation', with: '123asd!@#'
    shopper.click_button 'Register'
    assert shopper.has_content?('You have registered successfully.')
  end
end
