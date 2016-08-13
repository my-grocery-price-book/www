# == Schema Information
#
# Table name: price_book_pages
#
#  id            :integer          not null, primary key
#  name          :string
#  category      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  product_names :text             default([]), is an Array
#  unit          :string
#  price_book_id :integer
#

class PriceBook::Page < ApplicationRecord
  belongs_to :book, class_name: 'PriceBook', foreign_key: 'price_book_id'
  validates :name, :category, :unit, presence: true
  # on update only allows build pages for an unsaved PriceBook
  validates :price_book_id, presence: true, on: :update
  validates_uniqueness_of :name, scope: [:price_book_id, :unit]

  before_save :uniq_product_names, :reject_blank_names

  UNITS = ['grams', 'kilograms', 'milliliters', 'liters', 'gallons', 'pounds', 'items', 'each',
           'bags', 'packages', 'sheets', 'rolls', 'centimeters', 'meters', 'inches', 'ounces',
           'pints', 'yard', 'cubic feet', 'cubic inches', 'cubic meters', 'fluid ounces',
           'quarts', 'square feet', 'square inch', 'square meter', 'square yard'].freeze

  # @param [Store] store
  def add_store_to_book!(store)
    book.add_store!(store)
  end

  # @return [PriceEntry]
  def best_entry
    @best_entry ||= entries.to_a.min_by(&:price_per_unit)
  end

  # @return [Array<PriceEntry>]
  def entries
    PriceEntry.for_product_names(product_names, unit: unit, store_ids: book.store_ids)
  end

  # @param [String] name
  def add_product_name!(name)
    product_names << name
    save!
  end

  # @param [PriceEntry] entry
  # @param [Hash] params
  # @return [Boolean]
  def update_entry(entry, params)
    self.class.transaction do
      entry.attributes = params
      add_product_name!(entry.product_name)
      entry.save
    end
  end

  # @param [PriceBook] book
  # @return [Array<PriceBook::Page>]
  def self.for_book(book)
    where(price_book_id: book.id)
  end

  def self.find_page!(book, id)
    for_book(book).find(id)
  end

  protected

  def uniq_product_names
    product_names.uniq!
  end

  def reject_blank_names
    product_names.reject!(&:blank?)
  end

  public

  def info
    { name: name, category: category, unit: unit }
  end
end
