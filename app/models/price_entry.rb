# == Schema Information
#
# Table name: price_entries
#
#  id           :integer          not null, primary key
#  date_on      :date             not null
#  store_id     :integer
#  product_name :string           not null
#  amount       :integer          not null
#  package_size :integer          not null
#  package_unit :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  total_price  :money            not null
#

class PriceEntry < ActiveRecord::Base
  belongs_to :store
  validates :date_on, :product_name, :package_unit, presence: true
  validates_numericality_of :amount, :package_size, :total_price, greater_than: 0

  before_validation :strip_spacing

  def strip_spacing
    product_name.try(:strip!)
  end

  def price_per_unit
    total_price / (amount * package_size)
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
    ).limit(100)
  end
end
