require 'features_helper'

class SharingAShoppingListTest < FeatureTest
  setup do
    @grant = ShopperPersonaSession.new(email: 'grant@example.com')
    @grant.sign_up
    @kim = ShopperPersonaSession.new(email: 'kim@example.com')
  end

  test 'Grant and kim work together on a shopping list' do
    @grant.perform do
      click_link 'Price Book'
      click_link 'Invite'
      fill_in 'Name', with: 'Kim'
      fill_in 'Email', with: 'kim@example.com'
      click_button 'Invite'
    end

    @kim.perform do
      click_link_in_email 'My Price Book'
      sign_up
      click_button 'Accept'
    end

    @grant.perform do
      click_link 'Shopping List'
      click_on 'New Shopping List'
      click_button 'Edit Title'
      fill_in 'Title', with: 'Our Shopping'
      click_button 'Update'
    end

    assert @grant.has_css?('span', text: 'Our Shopping')
    if @grant.has_css?('span', text: 'Update Failed')
      puts `cat log/test.log`
    end
    assert @grant.has_no_css?('span', text: 'Update Failed')

    @kim.perform do
      click_link 'Shopping List'
      click_link 'Items'
      fill_in 'Item name', with: 'bread'
      fill_in 'Unit', with: 'loaves'
      fill_in 'Amount', with: '2'
      click_button 'Add'
    end

    assert @kim.has_content?('bread')

    @grant.click_link 'Refresh'

    assert @grant.has_content?('bread')
  end
end