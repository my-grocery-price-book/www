# frozen_string_literal: true
# == Schema Information
#
# Table name: price_entries
#
#  old_id       :integer
#  date_on      :date             not null
#  old_store_id :integer
#  product_name :string           not null
#  amount       :integer          not null
#  package_size :integer          not null
#  package_unit :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  total_price  :money            not null
#  id           :uuid             not null, primary key
#  store_id     :uuid
#

class PriceEntry < ApplicationRecord
  belongs_to :store
  validates :date_on, :product_name, :package_unit, :store_id, presence: true
  validates_numericality_of :amount, :package_size, :total_price, greater_than: 0

  before_validation :strip_spacing
  has_one :entry_owner

  def store_name
    store.name
  end

  def location
    store.location
  end

  def currency_symbol
    RegionFinder.instance.find_by_code(store.region_code).currency_symbol
  end

  def strip_spacing
    self.product_name = product_name.strip if product_name.is_a?(String)
  end

  def price_per_unit
    total_price / (amount * package_size)
  end

  def rounded_price_per_unit
    format('%.3e', price_per_unit).to_f
  end

  def price_per_package
    total_price / amount
  end

  # @param [Array<String>] product_names
  # @param [String] unit
  # @param [Array<Integer>] store_ids
  def self.for_product_names(product_names, unit:, store_ids:)
    matching_names = product_names.map do |name|
      name.downcase.gsub(/\s/, '')
    end
    where(package_unit: unit, store_id: store_ids).where(
      'replace(LOWER(product_name), \' \', \'\') IN (?)',
      matching_names
    ).order('date_on DESC').limit(100)
  end
end
