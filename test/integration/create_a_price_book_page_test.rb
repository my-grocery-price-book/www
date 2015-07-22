require 'integration_helper'

class CreateAPriceBookPageTest < ActionDispatch::IntegrationTest
  test 'create a new regular item' do
    visit '/price_book_pages'
    sign_in_shopper
    assert page.has_content?('Price Book')
    click_link 'New Price Book Page'
    fill_in 'Name', with: 'Bread'
    select 'Bakery', from: 'Category'
    fill_in 'Unit', with: 'Grams'
    click_button 'Create'
    page.save_page
    assert page.has_css?('.notice', text: 'Page was successfully created.')
    assert page.has_content?('Bread')
  end
end
