# frozen_string_literal: true
require 'test_helper'

class EntriesIntegrationTest < IntegrationTest
  attr_reader :current_page
  attr_reader :current_price_book
  attr_reader :current_shopper

  setup do
    @current_shopper = FactoryGirl.create(:shopper)
    login_shopper(@current_shopper)
    @current_price_book = PriceBook.create!(shopper: @current_shopper)
    @current_page = FactoryGirl.create(:page, book: @current_price_book)
  end

  def base_url
    "/books/#{current_price_book.to_param}/pages/#{current_page.to_param}/entries"
  end

  context 'GET /books/:book_id/pages/:page_id/entries/:id/edit' do
    context 'own entry' do
      should 'show edit page' do
        entry = FactoryGirl.create(:price_entry)
        EntryOwner.create!(price_entry: entry, shopper: current_shopper)
        get "#{base_url}/#{entry.to_param}/edit"
        assert_response :success
        assert response.body.include?('Edit')
      end
    end

    context 'other shoppers entry' do
      should 'should raise ActiveRecord::RecordNotFound' do
        entry = FactoryGirl.create(:price_entry)
        assert_raises(ActiveRecord::RecordNotFound) do
          get "#{base_url}/#{entry.to_param}/edit"
        end
      end
    end

    context 'none existing book' do
      should 'should raise ActiveRecord::RecordNotFound' do
        assert_raises(ActiveRecord::RecordNotFound) do
          get "#{base_url}/0/edit"
        end
      end
    end
  end

  context 'PUT /books/:book_id/pages/:page_id/entries/:id' do
    context 'own entry' do
      setup do
        @entry = FactoryGirl.create(:price_entry)
        EntryOwner.create!(price_entry: @entry, shopper: current_shopper)
      end

      context 'validation failed' do
        should 'show edit page' do
          put "#{base_url}/#{@entry.to_param}",
              params: { price_entry: { product_name: '' } }
          assert_response :success
          assert response.body.include?('Edit')
        end

        should 'show error messages' do
          put "#{base_url}/#{@entry.to_param}",
              params: { price_entry: { product_name: '' } }
          assert_response :success
          assert page.has_content?('Product name can\'t be blank')
        end
      end

      context 'successful save' do
        should 'redirects' do
          put "#{base_url}/#{@entry.to_param}",
              params: { price_entry: { product_name: 'New Name' } }
          assert_redirected_to book_page_path(current_price_book, current_page)
        end

        should 'update entry' do
          new_values = { 'date_on' => 5.days.ago.to_date,
                         'store_id' => FactoryGirl.create(:store).id,
                         'product_name' => 'Something new',
                         'amount' => 22,
                         'package_size' => 100,
                         'total_price' => 32 }
          put "#{base_url}/#{@entry.to_param}",
              params: { price_entry: new_values }
          @entry.reload
          saved_values = @entry.attributes.slice(*new_values.keys)
          assert_equal(new_values, saved_values)
        end
      end
    end

    context 'other shoppers entry' do
      should 'should raise ActiveRecord::RecordNotFound' do
        entry = FactoryGirl.create(:price_entry)
        assert_raises(ActiveRecord::RecordNotFound) do
          put "#{base_url}/#{entry.to_param}"
        end
      end
    end

    context 'none existing book' do
      should 'should raise ActiveRecord::RecordNotFound' do
        assert_raises(ActiveRecord::RecordNotFound) do
          put "#{base_url}/0"
        end
      end
    end
  end
end
