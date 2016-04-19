require 'integration_helper'

class BuildShoppingListTest < IntegrationTest
  def create_shopping_list
    assert page.has_text?('Shopping List')
    click_on 'New Shopping List'
    fill_in 'Item name', with: 'bread'
    click_button 'Add'

    assert page.has_text?('bread')

    fill_in 'Item name', with: 'eggs'
    click_button 'Add'

    assert page.has_text?('bread')
    assert page.has_text?('eggs')

    fill_in 'Item name', with: 'milk'
    click_button 'Add'

    assert page.has_text?('bread')
    assert page.has_text?('eggs')
    assert page.has_text?('milk')

    within('[data-item-name="bread"]') do
      click_on 'purchased'
    end

    within('[data-item-name="eggs"]') do
      click_on 'delete'
      click_on 'OK' # confirm the delete
    end

    using_wait_time(5) do
      assert page.has_no_text?('eggs')
      assert page.has_text?('bread')
      assert page.has_text?('milk')
    end
  end

  test 'create shopping list as logged in shopper' do
    visit '/shopping_lists'
    sign_in_shopper
    create_shopping_list
  end

  test 'create shopping list as guest' do
    visit '/shopping_lists'
    sign_in_guest
    create_shopping_list
  end
end
