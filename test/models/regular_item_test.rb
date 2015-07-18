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
  test 'must have a name' do
    regular_item = RegularItem.new
    assert_not regular_item.save
  end

  test 'name must be unique per shopper' do
    shopper = Shopper.create
    RegularItem.create(:shopper => shopper, :name => 'Potatoes')
    regular_item = RegularItem.new(:shopper => shopper, :name => 'Potatoes')
    assert_not regular_item.save
  end
end
