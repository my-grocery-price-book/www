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
  validates_uniqueness_of :name, scope: [:price_book_id, :unit]

  before_validation :uniq_product_names

  protected

  def uniq_product_names
    product_names.uniq!
  end

  public

  def info
    {name: name, category: category, unit: unit}
  end

  def to_param
    "#{category}_#{unit}_#{name}".downcase
  end
end
