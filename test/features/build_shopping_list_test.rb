require 'integration_helper'

class BuildShoppingListTest < ActionDispatch::IntegrationTest
  test 'create a new shopping list' do
    visit '/shopping_lists'
    sign_in_shopper
    assert page.has_content?('Shopping List')
    click_on 'New Shopping List'
    fill_in 'Item name', with: 'bread'
    fill_in 'Unit', with: 'loaves'
    fill_in 'Amount', with: '2'
    click_button 'Add'

    assert page.has_content?('bread')

    fill_in 'Item name', with: 'eggs'
    fill_in 'Amount', with: '1'
    fill_in 'Unit', with: 'dozens'
    click_button 'Add'

    assert page.has_content?('bread')
    assert page.has_content?('eggs')

    fill_in 'Item name', with: 'milk'
    fill_in 'Amount', with: '2'
    fill_in 'Unit', with: 'liters'
    click_button 'Add'

    assert page.has_content?('bread')
    assert page.has_content?('eggs')
    assert page.has_content?('milk')

    within('#bread_item') do
      click_on 'done'
    end

    within('#eggs_item') do
      click_on 'remove'
    end

    assert page.has_content?('bread')
    assert page.has_content?('milk')
    assert page.has_no_content?('eggs')

    visit '/shopping_lists'
    assert page.has_content?('1/2') # showing 1 of 2
  end
end
