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

  def total_cost
    items.sum(:total_price)
  end
end
