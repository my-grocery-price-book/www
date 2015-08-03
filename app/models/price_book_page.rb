# == Schema Information
#
# Table name: price_book_pages
#
#  id            :integer          not null, primary key
#  name          :string
#  category      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  shopper_id    :integer
#  product_names :text             default([]), is an Array
#  unit          :string
#

class PriceBookPage < ActiveRecord::Base
  belongs_to :shopper

  before_validation :uniq_product_names

  protected

  def uniq_product_names
    product_names.uniq!
  end

  public

  validates :name, :category, :unit, presence: true
  validates_uniqueness_of :name, :scope => [:shopper_id, :unit]

  def self.for_shopper(shopper)
    where(shopper_id: shopper)
  end

  def self.update_product_for_shopper!(shopper,info)
    item = for_shopper(shopper).find_or_initialize_by(
      category: info[:category],
      name: info[:regular_name],
      unit: info[:package_unit]
    )
    item.product_names << info[:product_brand_name]
    item.save
  end
end
