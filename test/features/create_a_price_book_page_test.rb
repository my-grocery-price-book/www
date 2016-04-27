require 'integration_helper'

class CreateAPriceBookPageTest < IntegrationTest
  test 'create a new page' do
    visit '/price_book_pages'
    sign_in_shopper
    assert page.has_content?('Price Book')
    click_link 'New Page'
    fill_in 'Name', with: 'Viennas'
    select 'Fresh', from: 'Category'
    select 'grams', from: 'Unit'
    click_button 'Create'
    assert page.has_css?('#notice', text: 'Page was successfully created.')
    assert page.has_content?('Viennas')
  end
end
