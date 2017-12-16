# frozen_string_literal: true

require 'test_helper'

class BookStoresIntegrationTest < IntegrationTest
  attr_reader :price_book

  setup do
    shopper = create_shopper
    @price_book = PriceBook.create!(shopper: shopper)
    login_shopper(shopper)
  end

  def assert_requires_book_region
    assert_redirected_to edit_book_path(price_book)
    assert_equal 'book requires region first', flash[:alert]
    assert_equal(new_book_store_path(price_book), session[:book_update_return])
  end

  context 'GET /books/:book_id/stores/new' do
    context 'book region codes sets' do
      setup do
        price_book.update!(region_codes: [RegionFinder.instance.first_code])
      end

      should 'render the new form ' do
        get "/books/#{price_book.to_param}/stores/new"
        assert_response :success
        assert response.body.include?('New Store')
        assert response.body.include?('<form')
      end
    end

    context 'no book region codes set' do
      should 'redirect to price book edit page' do
        get "/books/#{price_book.to_param}/stores/new"
        assert_requires_book_region
      end
    end
  end

  def post_stores(params)
    post "/books/#{price_book.to_param}/stores", params: params
  end

  context 'POST /books/:book_id/stores' do
    context 'book region codes set' do
      setup do
        price_book.update!(region_codes: [RegionFinder.instance.first_code])
      end

      context 'success' do
        setup do
          post_stores store: { name: 'Shop', location: 'Place', region_code: 'ZAR-WC' }
        end

        should 'save the record' do
          values = Store.last.attributes.slice('name', 'location', 'region_code')
          assert_equal({ 'name' => 'Shop', 'location' => 'Place', 'region_code' => 'ZAR-WC' },
                       values)
        end

        should 'set stores in price_book' do
          price_book.reload
          assert_includes price_book.stores, Store.last
        end

        should 'redirect to price_pages_path' do
          assert_redirected_to(book_pages_path)
        end
      end

      context 'validation errors' do
        should 'render the edit form with errors' do
          post_stores store: { name: '', location: '', region_code: 'ZAR-WC' }
          assert_response :success
          assert response.body.include?('<form'), 'does not contain form'
          assert response.body.include?('error-explanation'), 'does not contain errors'
        end
      end
    end

    context 'no book region codes set' do
      should 'redirect to price book edit page' do
        post "/books/#{price_book.to_param}/stores"
        assert_requires_book_region
      end
    end
  end
end
