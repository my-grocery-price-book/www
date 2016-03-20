require 'integration_helper'

class BuildShoppingListTest < ActionDispatch::IntegrationTest
  test 'create a new shopping list' do
    visit '/shopping_lists'
    sign_in_shopper
    assert page.has_text?('Shopping List')
    click_on 'New Shopping List'
    fill_in 'Item name', with: 'bread'
    fill_in 'Unit', with: 'loaves'
    fill_in 'Amount', with: '2'
    click_button 'Add'

    assert page.has_text?('bread')

    fill_in 'Item name', with: 'eggs'
    fill_in 'Amount', with: '1'
    fill_in 'Unit', with: 'dozens'
    click_button 'Add'

    assert page.has_text?('bread')
    assert page.has_text?('eggs')

    fill_in 'Item name', with: 'milk'
    fill_in 'Amount', with: '2'
    fill_in 'Unit', with: 'liters'
    click_button 'Add'

    assert page.has_text?('bread')
    assert page.has_text?('eggs')
    assert page.has_text?('milk')

    within('[data-item-name="bread-loaves"]') do
      click_on 'purchased'
    end

    within('[data-item-name="eggs-dozens"]') do
      click_on 'delete'
      click_on 'OK' # confirm the delete
    end

    assert page.has_no_text?('eggs')
    assert page.has_text?('bread')
    assert page.has_text?('milk')
  end
end
