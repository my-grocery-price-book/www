# == Schema Information
#
# Table name: purchases
#
#  id           :integer          not null, primary key
#  purchased_on :date
#  store        :string
#  location     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  shopper_id   :integer
#

require 'test_helper'

describe Purchase do
  let(:shopper) {create(:shopper)}

  describe '.create_for_shopper!' do

    it 'creates a purchase and item' do
      Purchase.create_for_shopper!(shopper)
      purchase = Purchase.for_shopper(shopper).first
      purchase.items.size.must_equal 1
    end
  end

  describe '#create_item!' do
    it 'creates an item' do
      purchase = Purchase.create_for_shopper!(shopper)
      purchase.create_item!
      purchase.items.size.must_equal 2
    end
  end
end
