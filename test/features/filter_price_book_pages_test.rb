require 'features_helper'

class FilterPriceBookPagesTest < FeatureTest
  test 'create a new page' do
    @shopper = ShopperPersonaSession.new(email: 'shopper@example.com')
    @shopper.sign_up
    @shopper.visit '/price_book_pages'
    assert @shopper.has_content?('Price Book')

    assert @shopper.has_content?('Apples')
    assert @shopper.has_content?('Cabbage')
    assert @shopper.has_content?('Cheese')

    @shopper.fill_in 'Filter', with: 'C'
    assert @shopper.has_no_content?('Apples')
    assert @shopper.has_content?('Cabbage')
    assert @shopper.has_content?('Cheese')

    @shopper.fill_in 'Filter', with: 'Ch'
    assert @shopper.has_no_content?('Apples')
    assert @shopper.has_no_content?('Cabbage')
    assert @shopper.has_content?('Cheese')
  end
end
