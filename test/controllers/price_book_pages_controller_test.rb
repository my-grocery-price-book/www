require 'test_helper'

class PriceBookPagesControllerTest < ActionController::TestCase
  setup do
    @price_book = create(:price_book)
    @shopper = @price_book.shopper
    @price_book_page = create(:price_book_page, price_book_id: @price_book.id)
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
  end

  context 'GET show' do
    should 'show price_book_page' do
      get :show, id: @price_book_page.to_param
      assert_response :success
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
      patch :update, id: @price_book_page,
                     price_book_page: {unit: 'U1', category: 'C1', name: 'N1' }
      @price_book_page.reload
      @price_book_page.info.must_equal(unit: 'U1', category: 'C1', name: 'N1')
      assert_redirected_to price_book_pages_path
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
