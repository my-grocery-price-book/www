# == Schema Information
#
# Table name: shopping_list_items
#
#  old_id               :integer
#  old_shopping_list_id :integer
#  name                 :string
#  amount               :integer          default(1), not null
#  unit                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  id                   :uuid             not null, primary key
#  shopping_list_id     :uuid
#

class ShoppingList::Item < ApplicationRecord
  has_one :purchase,
          class_name: 'ShoppingList::ItemPurchase',
          foreign_key: 'shopping_list_item_id',
          dependent: :destroy

  def purchase!
    create_purchase
    touch
  end

  def unpurchase!
    purchase.destroy
    reload
    touch
  end

  # @param [Shopper] shopper
  def self.for_shopping_list_ids(shopping_list_ids)
    where(shopping_list_id: shopping_list_ids)
  end

  def purchased_at
    purchase.try(:created_at)
  end
end
