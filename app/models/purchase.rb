class Purchase < ActiveRecord::Base
  has_many :items, class_name: 'PurchaseItem', dependent: :delete_all
  belongs_to :shopper

  def self.for_shopper(shopper)
    where(shopper_id: shopper)
  end

  def total_cost
    items.sum(:total_price)
  end
end
