# == Schema Information
#
# Table name: shopping_lists
#
#  id                              :integer          not null, primary key
#  _deprecated_shopper_id          :integer
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  title                           :string
#  price_book_id                   :integer
#  _deprecated_shopper_id_migrated :boolean          default(FALSE), not null
#

class ShoppingList < ApplicationRecord
  validates :price_book_id, presence: true
  belongs_to :book, class_name: 'PriceBook', foreign_key: 'price_book_id'
  has_many :items, dependent: :destroy

  before_save :set__deprecated_shopper_id_migrated

  def set__deprecated_shopper_id_migrated
    self._deprecated_shopper_id_migrated = true
  end

  # @param [Shopper] shopper
  def shopper=(shopper)
    self.price_book_id = PriceBook.default_for_shopper(shopper).id
  end

  def create_item!(*a)
    items.create!(*a)
  end

  # @param [Shopper] shopper
  # @return [ShoppingList]
  def self.first_for_shopper(shopper)
    for_shopper(shopper).first
  end

  # @param [Shopper] shopper
  # @return [Array<ShoppingList>]
  def self.for_shopper(shopper)
    price_book_id = PriceBook.default_for_shopper(shopper).id
    where(price_book_id: price_book_id).order('created_at DESC')
  end

  # @param [Shopper] shopper
  def self.items_for_shopper(shopper)
    shopping_list_ids = for_shopper(shopper).map(&:id)
    ShoppingList::Item.for_shopping_list_ids(shopping_list_ids)
  end

  # @param [PriceBook] book
  # @param [String] query
  # @return [Array<String>]
  def self.item_names_for_book(book, query:)
    shopping_list_ids = book.shopping_lists.map(&:id)
    items = ShoppingList::Item.where(shopping_list_id: shopping_list_ids).order(:name)
    filtered_items = items.where('name iLIKE ?', "%#{query}%").where('created_at > ?', 6.months.ago)
    filtered_items = filtered_items.select(:name).distinct.limit(100) # improve performance
    all_names = filtered_items.map(&:name)
    all_names.uniq!(&:downcase) # remove duplicates ignoring case
    all_names.first(10)
  end

  def title
    t = super
    t.present? ? t : created_at.try(:to_date)
  end

  def to_s
    "<ShoppingList id:#{id} title:#{title} />"
  end
end
