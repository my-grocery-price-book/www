# frozen_string_literal: true

require 'test_helper'

class ShoppingItemNamesIntegrationTest < IntegrationTest
  setup do
    @shopper = create_shopper
    login_shopper(@shopper)
  end

  context 'GET /books/:book_id/shopping_item_names.json' do
    setup do
      @book = PriceBook.create!(shopper: @shopper)
      shopping_list = ShoppingList.create!(price_book_id: @book.id)
      shopping_list.items.create(name: 'Bread')
      shopping_list.items.create(name: 'Eggs')
      shopping_list.items.create(name: 'Cheese')
    end

    should 'return all item names' do
      get "/books/#{@book.to_param}/shopping_item_names.json"
      assert_response :success
      parsed_body = MultiJson.load(response.body)
      assert_equal(%w[Bread Cheese Eggs], parsed_body['data'])
    end

    should 'return filtered item' do
      get "/books/#{@book.to_param}/shopping_item_names.json", params: { query: 'bread' }
      assert_response :success
      parsed_body = MultiJson.load(response.body)
      assert_equal(['Bread'], parsed_body['data'])
    end
  end
end
