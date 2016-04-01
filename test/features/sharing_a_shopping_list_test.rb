require 'features_helper'

class SharingAShoppingListTest < FeatureTest
  setup do
    @grant = ShopperPersonaSession.new(email: 'grant@example.com')
    @grant.sign_up
    @kate = ShopperPersonaSession.new(email: 'kate@example.com')
  end

  test 'Grant and kate work together on a shopping list' do
    @grant.perform do
      click_link 'Price Book'
      click_link 'Invite'
      fill_in 'Name', with: 'Kate'
      fill_in 'Email', with: 'kate@example.com'
      click_button 'Invite'
    end

    @kate.perform do
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
    assert @grant.has_no_css?('span', text: 'Update Failed')

    @kate.perform do
      click_link 'Shopping List'
      click_link 'Items'
      fill_in 'Item name', with: 'bread'
      fill_in 'Unit', with: 'loaves'
      fill_in 'Amount', with: '2'
      click_button 'Add'
    end

    assert @kate.has_content?('bread')

    @grant.using_wait_time(5) do
      assert @grant.has_content?('bread')
    end
  end
end