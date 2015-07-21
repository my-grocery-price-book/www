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

require 'test_helper'

class PurchaseItemTest < ActiveSupport::TestCase
  context 'validation' do
    should 'not be valid if product_brand_name not uniq per purchase' do
      purchase = purchases(:grant_purchase)
      PurchaseItem.create(purchase_id: purchase.id, product_brand_name: 'Sasko Bread')
      purchase_item = PurchaseItem.create(purchase_id: purchase.id, product_brand_name: 'Sasko Bread')
      assert_not_empty purchase_item.errors[:product_brand_name]
    end

    should 'be valid if product_brand_name uniq per purchase' do
      purchase = purchases(:grant_purchase)
      PurchaseItem.create(purchase_id: purchase.id, product_brand_name: 'Woolworths Bread')
      purchase_item = PurchaseItem.create(purchase_id: purchase.id, product_brand_name: 'Sasko Bread')
      assert_empty purchase_item.errors[:product_brand_name]
    end

    should 'be valid if same product_brand_name but different purchase' do
      purchase = purchases(:grant_purchase)
      purchase1 = purchases(:one)
      PurchaseItem.create(purchase_id: purchase.id, product_brand_name: 'Sasko Bread')
      purchase_item = PurchaseItem.create(purchase_id: purchase1.id, product_brand_name: 'Sasko Bread')
      assert_empty purchase_item.errors[:product_brand_name]
    end
  end
end
