# == Schema Information
#
# Table name: purchase_items
#
#  id                 :integer          not null, primary key
#  purchase_id        :integer
#  product_brand_name :string
#  package_size       :decimal(, )
#  package_unit       :string
#  quanity            :decimal(, )
#  total_price        :decimal(, )
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  category           :string
#

class PurchaseItem < ActiveRecord::Base
  validates_uniqueness_of :product_brand_name, scope: :purchase_id
  validates_numericality_of :package_size, greater_than: 0, allow_nil: true
  validates_numericality_of :quanity, greater_than: 0, allow_nil: true
end
