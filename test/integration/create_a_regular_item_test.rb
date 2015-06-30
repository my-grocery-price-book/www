require 'integration_helper'

class CreateARegularItemTest < ActionDispatch::IntegrationTest
  test 'create a new regular item' do
    visit '/regular_lists'
    sign_in_shopper
    assert page.has_content('Regular Shopping Items')
    click_link 'New Regular Item'
    fill_in 'Name', with: 'Bread'
    select 'Bakery', from: 'Category'
    click_button 'Create Regular Item'
    assert page.css?('.notice', text: 'Regular Item was successfully created.')
    assert page.has_content?('Bread')
  end
end