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
      @shopper.update_column(:current_public_api, 'ZA-EC')
      @price_book_page = @price_book.pages.create!(name: 'Apples', category: 'Fresh', unit: 'grams')
      stub_request(:get, 'https://api.example.com/ZA-EC/entries?category=Fresh&package_unit=grams')
        .to_return(status: 200, body: '[]')
    end

    should 'show price_book_page' do
      get :show, id: @price_book_page.to_param
      assert_response :success
    end

    should 'assign prices' do
      get :show, id: @price_book_page.to_param
      assert_instance_of(PriceEntriesService, assigns[:prices])
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
