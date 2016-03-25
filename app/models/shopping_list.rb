# == Schema Information
#
# Table name: shopping_lists
#
#  id            :integer          not null, primary key
#  shopper_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  title         :string
#  price_book_id :integer
#

class ShoppingList < ActiveRecord::Base
  validates :price_book_id, presence: true
  has_many :items, dependent: :destroy

  # @param [Shopper] shopper
  def shopper=(shopper)
    self.price_book_id = PriceBook.for_shopper(shopper).id
  end

  # @param [Shopper] shopper
  def self.for_shopper(shopper)
    price_book_id = PriceBook.for_shopper(shopper).id
    where(price_book_id: price_book_id).order('created_at DESC')
  end

  # @param [Shopper] shopper
  def self.items_for_shopper(shopper)
    shopping_list_ids = for_shopper(shopper).map(&:id)
    ShoppingList::Item.for_shopping_list_ids(shopping_list_ids)
  end

  def done_items
    items.where(done: true)
  end

  def title
    t = super
    t.present? ? t : created_at.to_date
  end
end
