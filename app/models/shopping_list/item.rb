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

class ShoppingList::Item < ApplicationRecord
  has_one :purchase,
          class_name: 'ShoppingList::ItemPurchase',
          foreign_key: 'shopping_list_item_id',
          dependent: :destroy

  def destroy_purchase
    purchase.destroy
    reload
  end

  # @param [Shopper] shopper
  def self.for_shopping_list_ids(shopping_list_ids)
    where(shopping_list_id: shopping_list_ids)
  end

  def purchased_at
    purchase.try(:created_at)
  end
end
