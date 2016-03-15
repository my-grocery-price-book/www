# == Schema Information
#
# Table name: shopping_list_items
#
#  id               :integer          not null, primary key
#  shopping_list_id :integer
#  name             :string
#  amount           :integer
#  unit             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class ShoppingList::Item < ActiveRecord::Base
  has_one :purchase, class_name: 'ShoppingList::ItemPurchase', foreign_key: 'shopping_list_item_id'
end
