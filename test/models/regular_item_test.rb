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
