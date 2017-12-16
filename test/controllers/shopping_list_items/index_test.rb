# frozen_string_literal: true

require 'test_helper'
require_relative 'shopping_list_items_helper'

class ShoppingListItemsIndexActionTest < ShoppingListItemsControllerTest
  setup do
    create_shopping_list_and_sign_in
  end

  should 'be success' do
    get :index, params: { shopping_list_id: shopping_list.to_param }
    assert_response :success
  end

  should 'be success with item no matching page' do
    item = shopping_list.create_item(name: 'Beans')
    get :index, params: { shopping_list_id: shopping_list.to_param }
    assert_response :success
    assert_includes response.body, item.name
  end

  should 'be success with item and matching page' do
    page = FactoryGirl.create(:page, book: price_book, name: 'Flour')
    shopping_list.create_item(name: page.name)
    get :index, params: { shopping_list_id: shopping_list.to_param }
    assert_response :success
    assert_includes response.body, page.name
  end

  should 'be success with item, matching page and best price' do
    page = FactoryGirl.create(:page, book: price_book, name: 'Flour')
    entry = add_entry(page: page, shopper: shopper)
    shopping_list.create_item(name: page.name)

    get :index, params: { shopping_list_id: shopping_list.to_param }
    assert_response :success
    assert_includes response.body, page.name
    assert_includes response.body, entry.currency_symbol.to_s
    assert_includes response.body, entry.price_per_package.to_s
  end

  should 'be 304 when requesting with same etag' do
    get :index, params: { shopping_list_id: shopping_list.to_param }
    etag = response.headers['ETag']
    request.env['HTTP_IF_NONE_MATCH'] = etag
    get :index, params: { shopping_list_id: shopping_list.to_param }
    assert_response 304
  end

  should 'give different etags for different formats' do
    get :index, params: { shopping_list_id: shopping_list.to_param }
    html_etag = response.headers['ETag']
    get :index, params: { shopping_list_id: shopping_list.to_param, format: 'json' }
    json_etag = response.headers['ETag']
    assert_not_equal html_etag, json_etag
  end
end
