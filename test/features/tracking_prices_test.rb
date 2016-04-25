require 'features_helper'

class TrackingPricesTest < FeatureTest
  setup do
    @grant = ShopperPersonaSession.new(email: 'grant@example.com')
    @grant.sign_up
    @pat = ShopperPersonaSession.new(email: 'pat@example.com')
    @pat.sign_up
  end

  test 'Grant tracks price of Sugar and Pat sees it' do
    @grant.perform do
      click_link 'Price Book'
      click_on 'Sugar'
      click_on 'New Price'

      # need to select a region first
      select 'South Africa - Western Cape', from: 'Region'
      click_on 'Save'

      save_screenshot
      # start filling in the price
      fill_in 'Product name', with: 'Koo Beans'
      fill_in 'Amount', with: '1'
      fill_in 'Package size', with: '410'
      fill_in 'Total price', with: '10'
      click_on 'Save'
    end

    # assert @grant.has_content?('Koo Beans')
    # assert @grant.has_content?('410 grams')
    #
    # @pat.perform do
    #   click_link 'Price Book'
    #   click_on 'Sugar'
    #   click_on 'Edit'
    #   fill_in 'Following product 1', with: 'Koo Beans'
    #   click_on 'Save'
    # end
    #
    # assert @pat.has_content?('Koo Beans')
    # assert @pat.has_content?('410 grams')
  end
end