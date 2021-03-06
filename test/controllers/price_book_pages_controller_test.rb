require 'test_helper'

class PriceBookPagesControllerTest < ActionController::TestCase
  setup do
    @shopper = create_shopper
    @price_book = PriceBook.create!(shopper: @shopper)
    @price_book_page = PriceBook::Page.create!(book: @price_book, name: 'n1', category: 'n2', unit: 'ml')
    sign_in @shopper, scope: :shopper
  end

  context 'GET index' do
    should 'be success' do
      get :index, params: { book_id: @price_book }
      assert_response :success
    end

    should 'be success with price entry' do
      store = FactoryGirl.create(:store, name: 'Checkers', location: 'George Mall')
      entry = FactoryGirl.create(:price_entry, product_name: 'Coke', store: store,
                                               package_unit: @price_book_page.unit)
      add_entry(page: @price_book_page, entry: entry, shopper: @shopper)
      get :index, params: { book_id: @price_book }
      assert_response :success
      assert response.body.include?('Coke')
      assert response.body.include?('Checkers')
      assert response.body.include?('George Mall')
    end
  end

  context 'GET new' do
    should 'get new' do
      get :new, params: { book_id: @price_book }
      assert_response :success
    end
  end

  context 'POST create' do
    should 'create price_book_page' do
      assert_difference('PriceBook::Page.for_book(@price_book).count') do
        post :create, params: { book_id: @price_book,
                                price_book_page: { category: 'Food', name: 'Banana', unit: 'KG' } }
      end

      assert_redirected_to book_pages_path(@price_book)
    end

    should 'render new on failure' do
      assert_no_difference('PriceBook::Page.for_book(@price_book).count') do
        post :create, params: { book_id: @price_book,
                                price_book_page: { category: '', name: 'Banana', unit: 'KG' } }
      end

      assert_response :success
    end
  end

  context 'GET show' do
    setup do
      @price_book_page = PriceBook::Page.create!(book: @price_book, name: 'Apples', category: 'Fresh', unit: 'grams')
    end

    should 'show price_book_page' do
      get :show, params: { book_id: @price_book, id: @price_book_page }
      assert_response :success
    end

    should 'shows prices' do
      @store = Store.create(name: 'Test', location: 'Test', region_code: 'ZAR-WC')
      @price_book.add_store(@store)
      @price_book_page.add_product_name('Red Apples')
      PriceEntry.create!(date_on: Date.current, store: @store, product_name: 'red apples',
                         amount: 42, package_size: 100, package_unit: 'grams', total_price: '508.66')

      get :show, params: { book_id: @price_book, id: @price_book_page }
      assert_response :success
      assert response.body.include?('red apples')
    end
  end

  context 'GET edit' do
    should 'get edit' do
      get :edit, params: { id: @price_book_page, book_id: @price_book }
      assert_response :success
    end
  end

  context 'PATCH update' do
    should 'update price_book_page' do
      patch :update, params: { id: @price_book_page, book_id: @price_book,
                               price_book_page: { unit: 'U1', category: 'C1', name: 'N1' } }
      @price_book_page.reload
      assert_equal({ unit: 'U1', category: 'C1', name: 'N1' }, @price_book_page.info)
      assert_redirected_to book_pages_path(@price_book)
    end

    should 'update price_book_page product_names' do
      patch :update, params: { id: @price_book_page, book_id: @price_book,
                               price_book_page: { product_names: %w[U1 C1] } }
      @price_book_page.reload
      assert_equal(%w[U1 C1], @price_book_page.product_names)
    end

    should 'fail to update price_book_page' do
      patch :update, params: { id: @price_book_page, book_id: @price_book,
                               price_book_page: { unit: '', category: '', name: '' } }
      @price_book_page.reload
      assert_not_equal({ unit: '', category: '', name: '' }, @price_book_page.info)
      assert_response :success
    end
  end

  context 'DELETE destroy' do
    should 'destroy price_book_page' do
      assert_difference('PriceBook::Page.for_book(@price_book).count', -1) do
        delete :destroy, params: { id: @price_book_page, book_id: @price_book }
      end

      assert_redirected_to book_pages_path(@price_book)
    end
  end
end
