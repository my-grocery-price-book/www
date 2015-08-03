# == Schema Information
#
# Table name: purchase_items
#
#  id                 :integer          not null, primary key
#  purchase_id        :integer
#  product_brand_name :string
#  package_size       :decimal(, )
#  package_unit       :string
#  quantity           :decimal(, )
#  total_price        :decimal(, )
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  category           :string
#  regular_name       :string
#

class PurchaseItem < ActiveRecord::Base
  validates_uniqueness_of :product_brand_name, scope: :purchase_id, allow_blank: true

  validates_numericality_of :package_size, greater_than: 0, allow_blank: true
  validates_numericality_of :quantity, greater_than: 0, allow_blank: true
  validates_numericality_of :total_price, greater_than: 0, allow_blank: true
end
