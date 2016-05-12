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

    assert @grant.has_no_css?('span', text: 'Update Failed'), 'Update Failed'
    skip('Broken on rails 5') if ENV['BUNDLE_GEMFILE'] == 'Gemfile-next'
    assert @grant.has_css?('h3', text: 'Our Shopping'), 'Our Shopping not visible'

    @kate.perform do
      click_link 'Shopping List'
      fill_in 'Item name', with: 'bread'
      click_button 'Add'
    end

    assert @kate.has_content?('bread'), 'bread not visible'

    @grant.using_wait_time(5) do
      assert @grant.has_content?('bread'), 'bread not visible'
    end
  end
end