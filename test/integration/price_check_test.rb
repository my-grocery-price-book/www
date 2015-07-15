require 'integration_helper'

class PriceCheckTest < ActionDispatch::IntegrationTest
  test 'Search for items when not logged in' do
    visit '/price_check'
    select 'North West', from: 'Current public api'
    click_button 'Set'

    assert page.has_content?('Search')
  end

  test 'Search for items when logged in' do
    visit '/profile'
    sign_in_shopper(current_public_api: 'za-nw')
    assert page.has_content?('Profile')
    assert page.has_content?('North West')

    click_link 'Price Check'
    assert page.has_content?('Search')
  end
end
