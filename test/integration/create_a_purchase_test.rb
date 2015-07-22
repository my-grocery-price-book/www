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
    fill_in 'Price Book Page', with: 'Soda'
    select 'Drinks', from: 'Category'
    fill_in 'Package size', with: '340'
    fill_in 'Package unit', with: 'ml'
    fill_in 'Quanity', with: '2'
    fill_in 'Total price', with: '10.99'
    click_button 'Save'
    assert page.has_css?('.notice', text: 'Purchase item was successfully created.')
    assert page.has_content?('Coke Lite')

    # create a second item
    click_link 'New Purchase item'
    fill_in 'Product brand name', with: 'Woolworths White Sugar'
    fill_in 'Price Book Page', with: 'Sugar'
    select 'Food Cupboard', from: 'Category'
    fill_in 'Package size', with: '500'
    fill_in 'Package unit', with: 'Kilograms'
    fill_in 'Quanity', with: '2'
    fill_in 'Total price', with: '18.95'
    click_button 'Save'
    assert page.has_css?('.notice', text: 'Purchase item was successfully created.')
    assert page.has_content?('Woolworths White Sugar')

    # page should have purchase total
    assert page.has_content?('29.94')

    click_link 'Price Book'
    assert page.has_content?('Sugar')
    assert page.has_content?('Soda')
  end
end
