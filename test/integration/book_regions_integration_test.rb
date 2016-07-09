require 'test_helper'

class BookRegionsIntegrationTest < IntegrationTest
  setup do
    @shopper = create_shopper
    login_shopper(@shopper)
    @price_book = PriceBook.create!(shopper: @shopper)
  end

  context 'GET /books/:book_id/regions/select_country' do
    context 'own book' do
      should 'list the countries' do
        get "/books/#{@price_book.to_param}/regions/select_country"
        assert_response :success
        assert response.body.include?('Select Country')
        assert response.body.include?('South Africa')
      end
    end

    context 'other shoopers book' do
      should 'render the new form ' do
        other_book = PriceBook.create!
        assert_raises(ActiveRecord::RecordNotFound) do
          get "/books/#{other_book.to_param}/regions/select_country"
        end
      end
    end

    context 'none existing book' do
      should 'should raise ActiveRecord::RecordNotFound' do
        assert_raises(ActiveRecord::RecordNotFound) do
          get '/books/0/regions/select_country'
        end
      end
    end
  end

  context 'GET /books/:book_id/regions/:country_code/new' do
    context 'own book' do
      should 'render the new form ' do
        get "/books/#{@price_book.to_param}/regions/ZAF/new"
        assert_response :success
        assert response.body.include?('Set Region')
        assert response.body.include?('<form')
      end
    end

    context 'other shoppers book' do
      should 'render the new form ' do
        other_book = PriceBook.create!
        assert_raises(ActiveRecord::RecordNotFound) do
          get "/books/#{other_book.to_param}/regions/ZAF/new"
        end
      end
    end

    context 'none existing book' do
      should 'should raise ActiveRecord::RecordNotFound' do
        assert_raises(ActiveRecord::RecordNotFound) do
          get '/books/0/regions/ZAF/new'
        end
      end
    end

    context 'none existing country_code' do
      should 'redirect to select_country' do
        get "/books/#{@price_book.to_param}/regions/XXXXXX/new"
        assert_redirected_to(select_country_book_regions_path(@price_book))
      end
    end
  end

  context 'POST /books/:book_id/regions/:country_code' do
    should 'save the record' do
      post "/books/#{@price_book.to_param}/regions/ZAF",
           params: { price_book: { region_codes: ['ZAF-WC'] } }
      @price_book.reload
      assert_equal(['ZAF-WC'], @price_book.region_codes)
    end

    should 'redirect to price_pages_path' do
      post "/books/#{@price_book.to_param}/regions/ZAF",
           params: { price_book: { region_codes: ['ZAF-WC'] } }
      assert_redirected_to(book_pages_path(@price_book))
    end

    should 'redirect to new_book_page_entry_path only once' do
      page = PriceBook::Page.create!(book: @price_book, name: 'Beans', category: 'Cupboard Food', unit: 'grams')

      get "/books/#{@price_book.to_param}/pages/#{page.to_param}/entries/new"
      assert_equal(new_book_page_entry_path(@price_book, page),
                   session[:book_regions_create_return])

      post "/books/#{@price_book.to_param}/regions/ZAF",
           params: { price_book: { region_codes: ['ZAF-WC'] } }
      assert_redirected_to(new_book_page_entry_path(@price_book, page))

      post "/books/#{@price_book.to_param}/regions/ZAF",
           params: { price_book: { region_codes: ['ZAF-WC'] } }
      assert_redirected_to(book_pages_path(@price_book))
    end
  end
end
