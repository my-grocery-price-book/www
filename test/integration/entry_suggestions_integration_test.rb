# frozen_string_literal: true

require 'test_helper'

class EntrySuggestionsIntegrationTest < IntegrationTest
  attr_reader :current_shopper
  attr_reader :current_price_book
  attr_reader :current_page

  setup do
    @current_shopper = FactoryGirl.create(:shopper)
    login_shopper(@current_shopper)
    @current_price_book = PriceBook.create!(shopper: @current_shopper)
    @current_page = FactoryGirl.create(:page, book: @current_price_book)
  end

  def base_url
    "/books/#{current_price_book.to_param}/entry_suggestions"
  end

  context 'GET /books/:book_id/entry_suggestions' do
    should 'show return names' do
      entry = FactoryGirl.create(:price_entry, product_name: 'My name')
      EntryOwner.create!(price_entry: entry, shopper: current_shopper)
      get "#{base_url}.json"
      assert_response :success
      assert_includes response.body, 'My name'
    end

    should 'show return names limit by query' do
      entry = FactoryGirl.create(:price_entry, product_name: 'My name')
      EntryOwner.create!(price_entry: entry, shopper: current_shopper)
      entry = FactoryGirl.create(:price_entry, product_name: 'Other name')
      EntryOwner.create!(price_entry: entry, shopper: current_shopper)
      get "#{base_url}.json", params: { query: 'My' }
      assert_response :success
      assert_includes response.body, 'My name'
      assert_not_includes response.body, 'Other name'
    end
  end
end
