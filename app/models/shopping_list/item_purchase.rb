# frozen_string_literal: true

# == Schema Information
#
# Table name: shopping_list_item_purchases
#
#  old_id                    :integer
#  old_shopping_list_item_id :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  id                        :uuid             not null, primary key
#  shopping_list_item_id     :uuid
#

class ShoppingList::ItemPurchase < ApplicationRecord
  after_save do
    ShoppingList::Item.find(shopping_list_item_id).touch # will expire caching
  end

  after_destroy do
    ShoppingList::Item.find(shopping_list_item_id).touch # will expire caching
  end
end
