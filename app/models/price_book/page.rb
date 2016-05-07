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

class PriceBook::Page < ActiveRecord::Base
  validates :name, :category, :unit, presence: true
  # on update only allows build pages for an unsaved PriceBook
  validates :price_book_id, presence: true, on: :update
  validates_uniqueness_of :name, scope: [:price_book_id, :unit]

  before_save :uniq_product_names, :reject_blank_names

  # @param [Array<Integer>] store_ids
  # @return [PriceEntry]
  def best_entry(store_ids)
    @best_entry ||= entries(store_ids).to_a.min_by do |entry|
      entry.total_price / (entry.amount * entry.package_size)
    end
  end

  # @param [Array<Integer>] store_ids
  # @return [Array<PriceEntry>]
  def entries(store_ids)
    PriceEntry.for_product_names(product_names, unit: unit, store_ids: store_ids)
  end

  # @param [String] name
  def add_product_name!(name)
    product_names << name
    save!
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
