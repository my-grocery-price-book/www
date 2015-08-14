require 'test_helper'

class PriceBookPagesControllerTest < ActionController::TestCase
  setup do
    @shopper = create(:shopper)
    @price_book_page = create(:price_book_page, shopper: @shopper)
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
      assert_difference('PriceBookPage.count') do
        post :create, price_book_page: { category: 'Food', name: 'Banana', unit: 'KG' }
        assert_empty assigns(:price_book_page).errors
      end

      assert_redirected_to price_book_pages_path
    end
  end

  context 'GET show' do
    should 'show price_book_page' do
      get :show, id: @price_book_page
      assert_response :success
    end
  end

  context 'GET edit' do
    should 'get edit' do
      get :edit, id: @price_book_page
      assert_response :success
    end
  end

  context 'PATCH update' do
    should 'update price_book_page' do
      patch :update, id: @price_book_page,
                     price_book_page: { category: @price_book_page.category, name: @price_book_page.name }
      assert_empty assigns(:price_book_page).errors
      assert_redirected_to price_book_page_path(assigns(:price_book_page))
    end
  end

  context 'DELETE destroy' do
    should 'destroy price_book_page' do
      assert_difference('PriceBookPage.count', -1) do
        delete :destroy, id: @price_book_page
      end

      assert_redirected_to price_book_pages_path
    end
  end
end
