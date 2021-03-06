# frozen_string_literal: true

require 'test_helper'
require_relative 'entries_integration_helper'

class EntriesCreateIntegrationTest < EntriesIntegrationTest
  setup do
    sign_in_and_create_page
  end

  def store
    @store ||= Store.create!(name: 'Test', location: 'New', region_code: 'ZAR-WC')
  end

  context 'POST /books/:book_id/pages/:page_id/entries' do
    context 'success' do
      setup do
        post "/books/#{price_book.to_param}/pages/#{book_page.to_param}/entries",
             params: { price_entry: { date_on: '2016-04-27', store_id: store.id,
                                      product_name: 'Cans of Coke', amount: '1',
                                      package_size: '340', total_price: '5.59' } }
        assert_response :redirect
      end

      should 'save the record' do
        entry = PriceEntry.last.attributes.except('id', 'old_id', 'old_store_id', 'created_at', 'updated_at')
        assert_equal({ 'date_on' => Date.parse('2016-04-27'), 'store_id' => store.id,
                       'product_name' => 'Cans of Coke', 'amount' => 1, 'package_size' => 340,
                       'total_price' => 5.59, 'package_unit' => 'grams' },
                     entry)
      end

      should 'assign entry to shopper' do
        entry = PriceEntry.last

        assert_includes(EntryOwner.entries_for_shopper(shopper), entry)
      end

      should 'adds product_name to page' do
        book_page.reload
        assert_includes(book_page.product_names, 'Cans of Coke')
      end

      should 'redirect to price_page_path' do
        assert_redirected_to(book_page_path(price_book, book_page))
      end
    end

    context 'validation errors' do
      should 'render the edit form with errors' do
        post "/books/#{price_book.to_param}/pages/#{book_page.to_param}/entries",
             params: { price_entry: { date_on: '', store_id: '', product_name: '', amount: '',
                                      package_size: '', total_price: '' } }
        assert_response :success
        assert response.body.include?('error_messages')
      end
    end
  end
end
