require 'features_helper'

class RegisterAndLoginTest < FeatureTest
  test 'login' do
    shopper = ShopperPersonaSession.new
    shopper.visit '/shopping_lists'
    shopper.click_on 'Create Account or Login'
    shopper.fill_in 'Name:', with: 'Tester'
    shopper.fill_in 'Email:', with: 'test@example.com'
    shopper.click_button 'Sign In'
    assert shopper.has_content?('Shopping Lists')
  end

  test 'guest register' do
    shopper = ShopperPersonaSession.new
    shopper.visit '/shopping_lists'
    shopper.click_on 'Log in as Guest'
    shopper.click_link 'Register'
    shopper.click_on 'Create Account or Login'
    shopper.fill_in 'Name:', with: 'Tester'
    shopper.fill_in 'Email:', with: 'test@example.com'
    shopper.click_button 'Sign In'
    assert shopper.has_content?('You have registered successfully.')
  end
end
