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

FactoryGirl.define do
  factory :purchase_item do
    sequence(:purchase_id)
    sequence(:product_brand_name) { |n| "item #{n}" }
    package_size 1
    quantity 1
    total_price 1
  end
end
