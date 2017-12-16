# frozen_string_literal: true

json.pages do
  json.partial! 'price_book_pages/pages', pages: pages
end
json.set_region_url select_country_book_regions_url(book)
json.edit_book_url edit_book_url(book)
json.new_page_url new_book_page_url(book)
json.invite_url new_book_invite_url(book)
json.authenticity_token form_authenticity_token
