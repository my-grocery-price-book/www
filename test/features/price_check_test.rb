require 'integration_helper'

class PriceCheckTest < IntegrationTest
  test 'Search for items when not logged in' do
    visit '/price_check'
    assert page.has_content?('Price Check')
  end

  test 'Search for items when logged in' do
    visit '/profile'
    sign_in_shopper

    click_link 'Price Check'
    assert page.has_content?('Price Check')
  end
end
