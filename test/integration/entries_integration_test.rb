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

class EntriesIntegrationTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  teardown do
    Warden.test_reset!
  end

  setup do
    Warden.test_mode!
    @shopper = create_shopper
    login_as(@shopper, scope: :shopper)
    @price_book = PriceBook.create!(shopper: @shopper)
    @page = @price_book.pages.create!(name: 'Beans', category: 'Cupboard Food', unit: 'grams')
  end

  context 'GET /books/:book_id/pages/:page_id/entries/new' do
    context 'book region codes sets' do
      setup do
        @price_book.update!(region_codes: [RegionFinder.instance.first_code])
      end

      context 'page exists' do
        should 'render the new form ' do
          get "/books/#{@price_book.to_param}/pages/#{@page.to_param}/entries/new"
          assert_response :success
          assert response.body.include?('<form'), 'does not contain form'
        end

        should 'set book_store_create_return session' do
          get "/books/#{@price_book.to_param}/pages/#{@page.to_param}/entries/new"
          assert_equal new_book_page_entry_path(@price_book, @page), session[:book_store_create_return]
        end
      end

      context 'page does not exist' do
        should 'raise ActiveRecord::RecordNotFound error' do
          assert_raises(ActiveRecord::RecordNotFound) do
            get "/books/#{@price_book.to_param}/pages/0/entries/new"
          end
        end
      end

      context 'page belongs to another book' do
        should 'raise ActiveRecord::RecordNotFound error' do
          another_book = PriceBook.create!
          page = another_book.pages.create!(name: 'Beans', category: 'Cupboard Food', unit: 'grams')
          assert_raises(ActiveRecord::RecordNotFound) do
            get "/books/#{@price_book.to_param}/pages/#{page.to_param}/entries/new"
          end
        end
      end
    end

    context 'no book region codes set' do
      should 'redirect to price book edit page' do
        get "/books/#{@price_book.to_param}/pages/#{@page.to_param}/entries/new"
        assert_redirected_to edit_book_path(@price_book)
      end

      should 'set a alert' do
        get "/books/#{@price_book.to_param}/pages/#{@page.to_param}/entries/new"
        assert_equal 'book requires region first', flash[:alert]
      end

      should 'set a price_book_save_return' do
        get "/books/#{@price_book.to_param}/pages/#{@page.to_param}/entries/new"
        assert_equal(new_book_page_entry_path(@price_book, @page), session[:book_update_return])
      end
    end
  end

  # context 'POST /books/:book_id/pages/:book_id/price_entries' do
  #   context 'success' do
  #     should 'save the record' do
  #       patch "/books/:book_id/pages/#{@price_book.to_param}", price_entry: { name: 'New Name' }
  #       @price_book.reload
  #       assert_equal 'New Name', @price_book.name
  #     end
  #
  #     should 'redirect to price_pages_path' do
  #       patch "/books/:book_id/pages/#{@price_book.to_param}", price_book: { name: 'New Name' }
  #       assert_redirected_to(price_pages_path)
  #     end
  #   end
  #
  #   context 'validation errors' do
  #     should 'render the edit form with errors' do
  #       patch "/books/:book_id/pages/#{@price_book.to_param}", price_book: { name: '' }
  #       assert_response :success
  #       assert response.body.include?('<form'), 'does not contain form'
  #       assert response.body.include?('error-explanation'), 'does not contain errors'
  #     end
  #   end
  # end
end
