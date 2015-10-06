# == Schema Information
#
# Table name: purchase_items
#
#  id                 :integer          not null, primary key
#  purchase_id        :integer
#  product_brand_name :string
#  package_size       :decimal(, )
#  package_unit       :string
#  quantity           :integer
#  total_price        :decimal(, )
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  category           :string
#  regular_name       :string
#

require 'test_helper'

class PurchaseItemTest < ActiveSupport::TestCase
  context 'validation' do
    context 'product_brand_name' do
      should 'not be valid if not uniq per purchase and regular_name' do
        PurchaseItem.create!(purchase_id: 11, product_brand_name: 'Sasko Bread', regular_name: 'Bread')
        purchase_item = PurchaseItem.create(purchase_id: 11, product_brand_name: 'Sasko Bread', regular_name: 'Bread')
        assert_not_empty purchase_item.errors[:product_brand_name]
      end

      should 'be valid if uniq per purchase' do
        PurchaseItem.create!(purchase_id: 1, product_brand_name: 'Woolworths Bread')
        purchase_item = PurchaseItem.create(purchase_id: 1, product_brand_name: 'Sasko Bread')
        assert_empty purchase_item.errors[:product_brand_name]
      end

      should 'be valid if same but different regular_name' do
        PurchaseItem.create!(purchase_id: 1, product_brand_name: 'Sasko Bread', regular_name: 'Bread')
        purchase_item = PurchaseItem.create(purchase_id: 1, product_brand_name: 'Sasko Bread', regular_name: 'W Bread')
        assert_empty purchase_item.errors[:product_brand_name]
      end

      should 'be valid if same but different purchase' do
        PurchaseItem.create!(purchase_id: 1, product_brand_name: 'Sasko Bread', regular_name: 'Bread')
        purchase_item = PurchaseItem.create(purchase_id: 2, product_brand_name: 'Sasko Bread', regular_name: 'Bread')
        assert_empty purchase_item.errors[:product_brand_name]
      end
    end

    context 'package_size' do
      should 'not be valid if not an integer ' do
        purchase_item = PurchaseItem.create(package_size: 'one')
        assert_not_empty purchase_item.errors[:package_size]
      end

      should 'not be valid if 0' do
        purchase_item = PurchaseItem.create(package_size: 0)
        assert_not_empty purchase_item.errors[:package_size]
      end

      should 'be valid if left empty' do
        purchase_item = PurchaseItem.create
        assert_empty purchase_item.errors[:package_size]
      end

      should 'be valid if greater than 0' do
        purchase_item = PurchaseItem.create(package_size: 9.99)
        assert_empty purchase_item.errors[:package_size]
      end
    end

    context 'quantity' do
      should 'not be valid if not an integer ' do
        purchase_item = PurchaseItem.create(quantity: 'one')
        assert_not_empty purchase_item.errors[:quantity]
      end

      should 'not be valid if 0' do
        purchase_item = PurchaseItem.create(quantity: 0)
        assert_not_empty purchase_item.errors[:quantity]
      end

      should 'be valid if left empty' do
        purchase_item = PurchaseItem.create
        assert_empty purchase_item.errors[:quantity]
      end

      should 'be valid if greater than 0' do
        purchase_item = PurchaseItem.create(quantity: 9.99)
        assert_empty purchase_item.errors[:quantity]
      end
    end

    context 'total_price' do
      should 'not be valid if not an integer ' do
        purchase_item = PurchaseItem.create(total_price: 'one')
        assert_not_empty purchase_item.errors[:total_price]
      end

      should 'not be valid if 0' do
        purchase_item = PurchaseItem.create(total_price: 0)
        assert_not_empty purchase_item.errors[:total_price]
      end

      should 'be valid if left empty' do
        purchase_item = PurchaseItem.create
        assert_empty purchase_item.errors[:total_price]
      end

      should 'be valid if greater than 0' do
        purchase_item = PurchaseItem.create(total_price: 9.99)
        assert_empty purchase_item.errors[:total_price]
      end
    end
  end
end
