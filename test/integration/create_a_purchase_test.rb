require 'integration_helper'

class CreatePurchaseTest < ActionDispatch::IntegrationTest
  test 'create new purchases and items' do
    visit '/purchases'
    sign_in_shopper
    assert page.has_content?('Listing Purchases')
    click_button 'New Purchases'
    assert page.has_content?('Editing Purchase')
    fill_in 'Store', with: 'Woolworths'
    fill_in 'Location', with: 'Canal Walk'
    click_button 'Update'
    assert page.has_css?('.notice', text: 'Purchase was successfully updated.')
    assert page.has_field?('Store', with: 'Woolworths')

    # create a item
    fill_in 'Product brand name', with: 'Coke Lite'
    fill_in 'Price Book Page', with: 'Soda'
    select 'Drinks', from: 'Category'
    fill_in 'Package size', with: '340'
    fill_in 'Package unit', with: 'ml'
    fill_in 'Quantity', with: '2'
    fill_in 'Total price', with: '10.99'
    click_button 'Save'
    assert page.has_content?('Editing Purchase')
    assert page.has_css?('.notice', text: 'Purchase item was successfully updated.')
    assert page.has_field?('Product brand name', with: 'Coke Lite')

    # create a second item
    click_button 'Add item'
    within('#item_0') do
      fill_in 'Product brand name', with: 'Woolworths White Sugar'
      fill_in 'Price Book Page', with: 'Sugar'
      select 'Food Cupboard', from: 'Category'
      fill_in 'Package size', with: '500'
      fill_in 'Package unit', with: 'Kilograms'
      fill_in 'Quantity', with: '2'
      fill_in 'Total price', with: '18.95'
      click_button 'Save'
    end
    assert page.has_css?('.notice', text: 'Purchase item was successfully updated.')
    assert page.has_field?('Product brand name', with: 'Coke Lite')
    assert page.has_field?('Product brand name', with: 'Woolworths White Sugar')

    click_link 'Price Book'
    assert page.has_content?('Sugar')
    assert page.has_content?('Soda')
  end
end
