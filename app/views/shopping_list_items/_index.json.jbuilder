# frozen_string_literal: true

json.array! shopping_list_items do |shopping_list_item|
  json.cache! shopping_list_item do
    json.partial! 'shopping_list_item', item: shopping_list_item
  end
end
