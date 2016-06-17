# == Schema Information
#
# Table name: invites
#
#  id            :integer          not null, primary key
#  price_book_id :integer
#  name          :string
#  email         :string
#  status        :string           default("sent"), not null
#  token         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class EntriesPostIntegrationTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  teardown do
    Warden.test_reset!
  end

  setup do
    Warden.test_mode!
    @shopper = create_shopper
    login_as(@shopper, scope: :shopper)
    @price_book = PriceBook.create!(shopper: @shopper)
    @page = PriceBook::Page.create!(book: @price_book, name: 'Beans', category: 'Cupboard Food', unit: 'grams')
  end

  context 'POST /books/:book_id/pages/:page_id/entries' do
    context 'success' do
      setup do
        @store = Store.create!(name: 'Test', location: 'New', region_code: 'ZAR-WC')
      end

      should 'save the record' do
        post "/books/#{@price_book.to_param}/pages/#{@page.to_param}/entries",
             price_entry: { date_on: '2016-04-27', store_id: @store.id, product_name: 'Cans of Coke',
                            amount: '1', package_size: '340', total_price: '5.59' }
        entry = PriceEntry.last.attributes.except('id', 'created_at', 'updated_at')
        assert_equal({ 'date_on' => Date.parse('2016-04-27'), 'store_id' => @store.id,
                       'product_name' => 'Cans of Coke', 'amount' => 1, 'package_size' => 340,
                       'total_price' => 5.59, 'package_unit' => 'grams' },
                     entry)
      end

      should 'assign entry to shopper' do
        post "/books/#{@price_book.to_param}/pages/#{@page.to_param}/entries",
             price_entry: { date_on: '2016-04-27', store_id: @store.id, product_name: 'Cans of Coke',
                            amount: '1', package_size: '340', total_price: '5.59' }
        entry = PriceEntry.last

        assert_includes(EntryOwner.entries_for_shopper(@shopper), entry)
      end

      should 'adds product_name to page' do
        post "/books/#{@price_book.to_param}/pages/#{@page.to_param}/entries",
             price_entry: { date_on: '2016-04-27', store_id: @store.id, product_name: 'Cans of Coke',
                            amount: '1', package_size: '340', total_price: '5.59' }
        @page.reload
        assert_includes(@page.product_names, 'Cans of Coke')
      end

      should 'redirect to price_page_path' do
        post "/books/#{@price_book.to_param}/pages/#{@page.to_param}/entries",
             price_entry: { date_on: '2016-04-27', store_id: @store.id, product_name: 'Cans of Coke',
                            amount: '1', package_size: '340', total_price: '5.59' }
        assert_redirected_to(book_page_path(@price_book, @page))
      end
    end

    context 'validation errors' do
      should 'render the edit form with errors' do
        post "/books/#{@price_book.to_param}/pages/#{@page.to_param}/entries",
             price_entry: { date_on: '', store_id: '', product_name: '', amount: '',
                            package_size: '', total_price: '' }
        assert_response :success
        assert response.body.include?('<form'), 'does not contain form'
        assert response.body.include?('error-explanation'), 'does not contain errors'
      end
    end
  end
end
