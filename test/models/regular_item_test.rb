# == Schema Information
#
# Table name: regular_items
#
#  id         :integer          not null, primary key
#  name       :string
#  category   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  shopper_id :integer
#

require 'test_helper'

class RegularItemTest < ActiveSupport::TestCase
  context 'validation' do
    should 'create a valid item' do
      RegularItem.create!(shopper: create(:shopper), name: 'Potatoes', category: 'Veg')
    end

    should 'not be valid without a name' do
      regular_item = RegularItem.create
      assert_not_empty regular_item.errors[:name]
    end

    should 'not be valid without catgeory' do
      regular_item = RegularItem.create
      assert_not_empty regular_item.errors[:category]
    end

    should 'not be valid if name not uniq per shopper' do
      shopper = create(:shopper)
      RegularItem.create!(shopper: shopper, name: 'Potatoes', category: 'Veg')
      regular_item = RegularItem.create(shopper: shopper, name: 'Potatoes', category: 'Veg')
      assert_not_empty regular_item.errors[:name]
    end

    should 'be valid if name uniq per shopper' do
      shopper = create(:shopper)
      RegularItem.create!(shopper: shopper, name: 'Potatoes', category: 'Veg')
      regular_item = RegularItem.create(shopper: shopper, name: 'Tomatoes', category: 'Veg')
      assert_empty regular_item.errors[:name]
    end

    should 'be valid if same name but different shopper' do
      RegularItem.create!(shopper: create(:shopper), name: 'Potatoes', category: 'Veg')
      regular_item = RegularItem.create(shopper: create(:shopper), name: 'Potatoes', category: 'Veg')
      assert_empty regular_item.errors[:name]
    end
  end
end

describe RegularItem do
  describe 'class methods' do

    describe 'update_product_for_shopper!' do
      before do
        @shopper = create(:shopper)
      end

      it 'creates a new item with product correct info' do
        RegularItem.update_product_for_shopper!(
          @shopper,
          product_brand_name: 'Coke Lite',
          regular_name: 'Soda',
          category: 'Drinks'
        )
        last_attributes = RegularItem.last.attributes.except('id', 'created_at', 'updated_at')
        last_attributes.must_equal('name' => 'Soda',
                                   'category' => 'Drinks',
                                   'product_names' => ['Coke Lite'],
                                   'shopper_id' => @shopper.id)
      end

      it 'adds the product_name to existing item' do
        current_item = create(:regular_item,
                              shopper: @shopper,
                              name: 'Soda',
                              category: 'Drinks',
                              product_names: ['Coke Lite'])
        RegularItem.update_product_for_shopper!(
          @shopper,
          product_brand_name: 'Fanta',
          regular_name: 'Soda',
          category: 'Drinks'
        )
        current_item.reload
        last_attributes = current_item.attributes.except('id', 'created_at', 'updated_at')
        last_attributes.must_equal('name' => 'Soda',
                                   'category' => 'Drinks',
                                   'product_names' => ['Coke Lite', 'Fanta'],
                                   'shopper_id' => @shopper.id)
      end

      it 'ignore product_name already on item' do
        current_item = create(:regular_item,
                              shopper: @shopper,
                              name: 'Soda',
                              category: 'Drinks',
                              product_names: ['Coke Lite'])
        RegularItem.update_product_for_shopper!(
          @shopper,
          product_brand_name: 'Coke Lite',
          regular_name: 'Soda',
          category: 'Drinks'
        )
        current_item.reload
        last_attributes = current_item.attributes.except('id', 'created_at', 'updated_at')
        last_attributes.must_equal('name' => 'Soda',
                                   'category' => 'Drinks',
                                   'product_names' => ['Coke Lite'],
                                   'shopper_id' => @shopper.id)
      end
    end
  end
end
