# frozen_string_literal: true
json.call(page, :id, :name, :category, :unit)
json.product_names do
  json.array! page.product_names
end
if page.best_entry
  json.best_entry do
    json.partial! 'entries/entry', entry: page.best_entry
  end
end
json.add_entry_url new_book_page_entry_url(page.price_book_id, page)
json.show_url book_page_url(page.price_book_id, page)
json.edit_url edit_book_page_url(page.price_book_id, page)
json.delete_url delete_book_page_url(page.price_book_id, page)
