# frozen_string_literal: true
json.call(shopping_list, :id, :title, :created_at, :updated_at)
json.update_url shopping_list_url(shopping_list)
json.delete_url shopping_list_url(shopping_list)
json.items_url shopping_list_items_url(shopping_list)
json.price_book_pages_url book_pages_url(shopping_list.price_book_id)
json.item_names_url book_shopping_item_names_url(shopping_list.price_book_id)
