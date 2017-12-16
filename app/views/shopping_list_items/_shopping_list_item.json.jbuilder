# frozen_string_literal: true

json.call(item, :id, :name, :amount, :unit, :purchased_at, :updated_at)
json.update_url shopping_list_item_url(item.shopping_list_id, item)
json.delete_url shopping_list_item_url(item.shopping_list_id, item)
json.purchase_url shopping_list_item_purchases_url(item.shopping_list_id, item)
json.unpurchase_url shopping_list_item_purchases_url(item.shopping_list_id, item)
