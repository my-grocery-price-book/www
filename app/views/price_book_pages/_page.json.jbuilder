json.call(page, :id, :name, :category, :unit)
json.product_names do
  json.array! page.product_names
end
json.best_entry do
  json.partial! 'entries/entry', entry: page.best_entry(store_ids)
end if page.best_entry(store_ids)
json.show_url book_page_url(page.price_book_id, page)
json.edit_url edit_price_book_page_url(page)
json.delete_url delete_price_book_page_url(page)
