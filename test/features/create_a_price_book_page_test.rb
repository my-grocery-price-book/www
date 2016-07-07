require 'features_helper'

class CreateAPriceBookPageTest < FeatureTest
  test 'create a new page' do
    @shopper = ShopperPersonaSession.new(email: 'shopper@example.com')
    @shopper.sign_up
    @shopper.visit '/price_book_pages'
    assert @shopper.has_content?('Price Book')
    @shopper.click_link 'New Page'
    @shopper.fill_in 'Name', with: 'Viennas'
    @shopper.select 'Fresh', from: 'Category'
    @shopper.select 'grams', from: 'Unit'
    @shopper.click_button 'Create'
    assert @shopper.has_css?('#notice', text: 'Page was successfully created.')
    assert @shopper.has_content?('Viennas')
  end
end
