json.call(shopping_list_item, :id, :name, :amount, :unit, :purchased_at)
json.update_url shopping_list_item_url(shopping_list_item)
json.delete_url shopping_list_item_url(shopping_list_item)
json.purchase_url shopping_list_item_purchases_url(shopping_list_item)
json.unpurchase_url shopping_list_item_purchases_url(shopping_list_item)