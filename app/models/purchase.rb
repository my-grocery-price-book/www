# == Schema Information
#
# Table name: purchases
#
#  id           :integer          not null, primary key
#  purchased_on :date
#  store        :string
#  location     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  shopper_id   :integer
#

class Purchase < ActiveRecord::Base
  has_many :items, class_name: 'PurchaseItem', dependent: :delete_all
  belongs_to :shopper

  def self.for_shopper(shopper)
    where(shopper_id: shopper)
  end

  def self.find_for_shopper(shopper,id)
    for_shopper(shopper).find(id)
  end

  def self.create_for_shopper!(shopper)
    for_shopper(shopper).create!
  end

  def total_cost
    items.sum(:total_price)
  end

  def new_item(item_params = {})
    items.new(item_params)
  end

  def find_item(id)
    items.find(id)
  end

  def save_item(item)
    item.save
  end

  def update_item(item, params)
    item.update(params)
  end

  def destroy_item_by_id(item_id)
    items.find(item_id).destroy
  end
end
