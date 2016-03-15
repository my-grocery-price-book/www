json.array! shopping_list_items do |shopping_list_item|
  json.partial! 'shopping_list_item', shopping_list_item: shopping_list_item
end
