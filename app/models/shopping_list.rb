# frozen_string_literal: true
# == Schema Information
#
# Table name: shopping_lists
#
#  old_id            :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  title             :string
#  old_price_book_id :integer
#  price_book_id     :uuid
#  id                :uuid             not null, primary key
#

class ShoppingList < ApplicationRecord
  validates :price_book_id, presence: true
  belongs_to :book, class_name: 'PriceBook', foreign_key: 'price_book_id'
  has_many :items, dependent: :destroy

  def ordered_items
    items.order(:created_at)
  end

  # @param [Shopper] shopper
  def shopper=(shopper)
    self.price_book_id = PriceBook.default_for_shopper(shopper).id
  end

  # @return [ShoppingList::Item]
  def create_item(*item_args)
    item = items.create!(*item_args)
    touch
    item
  end

  # @return [ShoppingList::Item]
  def find_item(item_id)
    items.find(item_id)
  end

  # @return [ShoppingList::Item]
  def update_item(item_id, *item_args)
    item = find_item(item_id)
    item.update!(*item_args)
    touch
    item
  end

  # @return [ShoppingList::Item]
  def destroy_item(item_id)
    item = find_item(item_id)
    item.destroy
    touch
    item
  end

  # @return [ShoppingList::Item]
  def purchase_item(item_id)
    item = find_item(item_id)
    item.purchase_it
    touch
    item
  end

  # @return [ShoppingList::Item]
  def unpurchase_item(item_id)
    item = find_item(item_id)
    item.unpurchase_it
    touch
    item
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

  # @param [PriceBook] book
  # @param [String] query
  # @return [Array<String>]
  def self.item_names_for_book(book, query:)
    items = ShoppingList::Item.where(shopping_list_id: book.shopping_lists.map(&:id)).order(:name)
    filtered_items = items.where('name iLIKE ?', "%#{query}%").where('created_at > ?', 6.months.ago)
    filtered_items = filtered_items.select(:name).distinct.limit(100) # improve performance
    all_names = filtered_items.map(&:name)
    all_names.uniq!(&:downcase) # remove duplicates ignoring case
    all_names.first(10)
  end

  def title
    saved_title = super
    saved_title.present? ? saved_title : created_at.try(:to_date)
  end

  def to_s
    "<ShoppingList id:#{id} title:#{title} />"
  end
end
