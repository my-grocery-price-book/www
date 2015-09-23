# == Schema Information
#
# Table name: shopping_lists
#
#  id         :integer          not null, primary key
#  shopper_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShoppingList < ActiveRecord::Base
  belongs_to :shopper
  has_many :items, dependent: :delete_all

  def self.for_shopper(shopper)
    where(shopper_id: shopper.id).order('created_at DESC')
  end

  def done_items
    items.where(done: true)
  end
end
