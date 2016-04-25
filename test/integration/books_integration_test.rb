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

class BooksIntegrationTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  teardown do
    Warden.test_reset!
  end

  setup do
    Warden.test_mode!
    @shopper = create_shopper
    login_as(@shopper, scope: :shopper)
    @price_book = PriceBook.create!(shopper: @shopper)
  end

  context 'GET /books/:book_id/edit' do
    should 'render the edit form' do
      get "/books/#{@price_book.to_param}/edit"
      assert_response :success
      assert response.body.include?('<form'), 'does not contain form'
    end
  end

  context 'PATCH /books/:book_id/update' do
    context 'success' do
      should 'save the record' do
        patch "/books/#{@price_book.to_param}",
              price_book: { name: 'New Name', region_codes: ['ZAR-WC'] }
        @price_book.reload
        new_values = @price_book.attributes.slice('name','region_codes')
        assert_equal({'name' => 'New Name', 'region_codes' => ['ZAR-WC']}, new_values)
      end

      should 'redirect to price_book_pages_path' do
        patch "/books/#{@price_book.to_param}", price_book: { name: 'New Name' }
        assert_redirected_to(price_book_pages_path)
      end

      should 'redirect to new_book_page_entry_path only once' do
        page = @price_book.pages.create!(name: 'Beans', category: 'Cupboard Food', unit: 'grams')

        get "/books/#{@price_book.to_param}/pages/#{page.to_param}/entries/new"
        assert_equal(new_book_page_entry_path(@price_book,page), session[:book_update_return])

        patch "/books/#{@price_book.to_param}", price_book: { name: 'New Name' }
        assert_redirected_to(new_book_page_entry_path(@price_book,page))

        patch "/books/#{@price_book.to_param}", price_book: { name: 'New Name' }
        assert_redirected_to(price_book_pages_path)
      end
    end

    context 'validation errors' do
      should 'render the edit form with errors' do
        patch "/books/#{@price_book.to_param}", price_book: { name: '' }
        assert_response :success
        assert response.body.include?('<form'), 'does not contain form'
        assert response.body.include?('error-explanation'), 'does not contain errors'
      end
    end
  end
end
