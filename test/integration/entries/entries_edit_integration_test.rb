# frozen_string_literal: true

require 'test_helper'
require_relative 'entries_integration_helper'

class EntriesEditIntegrationTest < EntriesIntegrationTest
  setup do
    sign_in_and_create_page
  end

  def base_url
    "/books/#{price_book.to_param}/pages/#{book_page.to_param}/entries"
  end

  context 'GET /books/:book_id/pages/:page_id/entries/:id/edit' do
    context 'own entry' do
      should 'show edit page' do
        entry = FactoryGirl.create(:price_entry)
        EntryOwner.create!(price_entry: entry, shopper: shopper)
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
end
