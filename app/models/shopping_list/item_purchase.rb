# == Schema Information
#
# Table name: shopping_list_item_purchases
#
#  id                    :integer          not null, primary key
#  shopping_list_item_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class ShoppingList::ItemPurchase < ActiveRecord::Base
end
