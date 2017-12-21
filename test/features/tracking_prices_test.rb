require 'features_helper'

class TrackingPricesTest < FeatureTest
  module TrackingShopper
    def add_sugar_entry
      add_entry_to_book('Sugar', product_name: 'White Sugar', amount: '1',
                                 package_size: '410', total_price: '10')
    end
  end

  setup do
    @grant = ShopperPersonaSession.new(email: 'grant@example.com').extend(TrackingShopper)
    @grant.sign_up
    @pat = ShopperPersonaSession.new(email: 'pat@example.com').extend(TrackingShopper)
    @pat.sign_up
  end

  test 'Grant tracks price of Sugar for the first time and Pat sees it' do
    @grant.add_sugar_entry

    assert @grant.has_content?('White Sugar')
    assert @grant.has_content?('410')

    @pat.perform do
      click_link 'Price Book'
      click_on 'Region'
    end

    @pat.set_book_region
    @pat.create_pick_n_pay_store

    @pat.perform do
      click_on 'Sugar'
      click_on 'Edit'
      fill_in 'Following product', with: 'White Sugar'
      click_on 'Update Page'
    end

    @pat.add_entry_to_book('Sugar', product_name: 'Brown Sugar', package_size: '400')

    assert @pat.has_content?('Brown Sugar')
    assert @pat.has_content?('400')
    assert @pat.has_content?('White Sugar')
    assert @pat.has_content?('410')
  end

  test 'Grant tracks price of Sugar incorrectly and needs to edit it' do
    @grant.add_sugar_entry

    assert @grant.has_content?('Sugar')
    assert @grant.has_content?('410')

    @grant.perform do
      click_link 'Edit Entry'

      # create correct store
      click_link 'New Store'
      fill_in 'Name', with: 'Checkers'
      fill_in 'Location', with: 'Langa'
      click_on 'Save'


      select 'Checkers - Langa', from: 'Store'
      fill_in 'Product name', with: 'White Sugar'
      fill_in 'Package size', with: '888'
      click_on 'Save'
    end

    assert @grant.has_content?('Checkers')
    assert @grant.has_content?('Langa')
    assert @grant.has_content?('White Sugar')
    assert @grant.has_content?('888')
  end

  test 'Grant tracks price of multiple items' do
    @grant.add_sugar_entry

    assert @grant.has_content?('White Sugar')
    assert @grant.has_content?('410')


  end
end