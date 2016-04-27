require 'test_helper'

class PriceBookPagesControllerTest < ActionController::TestCase
  setup do
    @shopper = create_shopper
    @price_book = PriceBook.create!(shopper: @shopper)
    @price_book_page = @price_book.pages.create!(name: 'n1', category: 'n2', unit: 'ml')
    sign_in :shopper, @shopper
  end

  context 'GET index' do
    should 'be success' do
      get :index
      assert_response :success
      assert_equal assigns(:price_book_pages), [@price_book_page]
    end
  end

  context 'GET new' do
    should 'get new' do
      get :new
      assert_response :success
    end
  end

  context 'POST create' do
    should 'create price_book_page' do
      assert_difference('@price_book.page_count') do
        post :create, price_book_page: { category: 'Food', name: 'Banana', unit: 'KG' }
      end

      assert_redirected_to price_book_pages_path
    end

    should 'render new on failure' do
      assert_no_difference('@price_book.page_count') do
        post :create, price_book_page: { category: '', name: 'Banana', unit: 'KG' }
      end

      assert_response :success
    end
  end

  context 'GET show' do
    setup do
      @price_book_page = @price_book.pages.create!(name: 'Apples', category: 'Fresh', unit: 'grams')
    end

    should 'show price_book_page' do
      get :show, id: @price_book_page.to_param
      assert_response :success
    end

    should 'shows prices' do
      @store = Store.create(name: 'Test', location: 'Test', region_code: 'ZAR-WC')
      @price_book.add_store!(@store)
      @price_book_page.add_product_name!('Red Apples')
      PriceEntry.create!(date_on: Date.current, store: @store, product_name: 'red apples',
                         amount: 42, package_size: 100, package_unit: 'grams', total_price: 508.66)

      get :show, id: @price_book_page.to_param
      assert_response :success
      assert response.body.include?('red apples')
    end
  end

  context 'GET edit' do
    should 'get edit' do
      get :edit, id: @price_book_page.to_param
      assert_response :success
    end
  end

  context 'PATCH update' do
    should 'update price_book_page' do
      patch :update, id: @price_book_page, price_book_page: { unit: 'U1', category: 'C1', name: 'N1' }
      @price_book_page.reload
      assert_equal({ unit: 'U1', category: 'C1', name: 'N1' }, @price_book_page.info)
      assert_redirected_to price_book_pages_path
    end

    should 'fail to update price_book_page' do
      patch :update, id: @price_book_page, price_book_page: { unit: '', category: '', name: '' }
      @price_book_page.reload
      assert_not_equal({ unit: '', category: '', name: '' }, @price_book_page.info)
      assert_response :success
    end
  end

  context 'DELETE destroy' do
    should 'destroy price_book_page' do
      assert_difference('@price_book.page_count', -1) do
        delete :destroy, id: @price_book_page
      end

      assert_redirected_to price_book_pages_path
    end
  end
end
