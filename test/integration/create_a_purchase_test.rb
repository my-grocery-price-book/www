require 'integration_helper'

class CreatePurchaseTest < ActionDispatch::IntegrationTest
  test 'create new purchases and items' do
    visit '/purchases'
    sign_in_shopper
    assert page.has_content?('Listing Purchases')
    click_link 'New Purchase'
    fill_in 'Store', with: 'Woolworths'
    fill_in 'Location', with: 'Canal Walk'
    click_button 'Create Purchase'
    assert page.has_css?('.notice', text: 'Purchase was successfully created.')
    assert page.has_content?('Woolworths')

    # create a item
    click_link 'New Purchase item'
    fill_in 'Product brand name', with: 'Coke Lite'
    fill_in 'Generic name', with: 'Soda'
    fill_in 'Package type', with: 'Can'
    fill_in 'Package size', with: '340'
    fill_in 'Package unit', with: 'ml'
    fill_in 'Quanity', with: '2'
    fill_in 'Total price', with: '10.99'
    click_button 'Create Purchase item'
    assert page.has_css?('.notice', text: 'Purchase item was successfully created.')
    assert page.has_content?('Coke Lite')
  end
end
