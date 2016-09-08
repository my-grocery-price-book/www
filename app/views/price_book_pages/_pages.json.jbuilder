# frozen_string_literal: true
json.array! pages do |page|
  json.partial! 'price_book_pages/page', page: page
end
