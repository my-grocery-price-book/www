json.call(shopping_list, :id, :title, :created_at, :updated_at)
json.update_url shopping_list_url(shopping_list)
json.delete_url shopping_list_url(shopping_list)
json.items_url shopping_list_items_url(shopping_list)
