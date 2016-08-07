# == Schema Information
#
# Table name: shopping_list_item_purchases
#
#  id                    :integer          not null, primary key
#  shopping_list_item_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class ShoppingList::ItemPurchase < ApplicationRecord
  after_save do
    ShoppingList::Item.find(shopping_list_item_id).touch # will expire caching
  end

  after_destroy do
    ShoppingList::Item.find(shopping_list_item_id).touch # will expire caching
  end
end
