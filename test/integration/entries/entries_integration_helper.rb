# frozen_string_literal: true

require 'test_helper'

class EntriesIntegrationTest < IntegrationTest
  def shopper
    @shopper ||= create_shopper
  end

  attr_reader :price_book
  attr_reader :book_page

  def sign_in_and_create_page
    login_shopper(shopper)
    @price_book = PriceBook.create!(shopper: shopper)
    @book_page = FactoryGirl.create(:page, book: price_book)
  end
end
