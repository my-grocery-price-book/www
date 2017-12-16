# frozen_string_literal: true

json.array! @shopping_lists do |shopping_list|
  json.partial! 'shopping_list', shopping_list: shopping_list
end
