require 'integration_helper'

class CreateARegularItemTest < ActionDispatch::IntegrationTest
  test 'create a new regular item' do
    visit '/regular_items'
    sign_in_shopper
    assert page.has_content?('Regular Shopping Items')
    click_link 'New Regular Item'
    fill_in 'Name', with: 'Bread'
    select 'Bakery', from: 'Category'
    click_button 'Create Regular Item'
    assert page.has_css?('.notice', text: 'Regular item was successfully created.')
    assert page.has_content?('Bread')
  end
end