# frozen_string_literal: true

require 'test_helper'

class BooksIntegrationTest < IntegrationTest
  setup do
    @shopper = create_shopper
    login_shopper(@shopper)
    @price_book = PriceBook.create!(shopper: @shopper)
  end

  context 'GET /books/:book_id/edit' do
    should 'render the edit form' do
      get "/books/#{@price_book.to_param}/edit"
      assert_response :success
      assert response.body.include?('<form'), 'does not contain form'
    end

    should 'raise ActiveRecord Exception for another book' do
      book = PriceBook.create!
      assert_raises(ActiveRecord::RecordNotFound) do
        get "/books/#{book.to_param}/edit"
      end
    end
  end

  context 'PATCH /books/:book_id/update' do
    context 'success' do
      should 'save the record' do
        patch "/books/#{@price_book.to_param}", params: { price_book: { name: 'New Name' } }
        @price_book.reload
        assert_equal('New Name', @price_book.name)
      end

      should 'redirect to book_pages_path' do
        patch "/books/#{@price_book.to_param}", params: { price_book: { name: 'New Name' } }
        assert_redirected_to(book_pages_path(@price_book))
      end
    end

    context 'validation errors' do
      should 'render the edit form with errors' do
        patch "/books/#{@price_book.to_param}", params: { price_book: { name: '' } }
        assert_response :success
        assert response.body.include?('<form'), 'does not contain form'
        assert response.body.include?('error-explanation'), 'does not contain errors'
      end
    end

    context 'other users book' do
      should 'raise ActiveRecord Exception' do
        book = PriceBook.create!
        assert_raises(ActiveRecord::RecordNotFound) do
          patch "/books/#{book.to_param}", params: { price_book: { name: '' } }
        end
      end
    end
  end
end
