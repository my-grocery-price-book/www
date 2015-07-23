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

class PurchaseTest < ActiveSupport::TestCase
  context 'total_cost' do
    should 'be correct' do
      purchase = create(:purchase)
      create(:purchase_item, purchase_id: purchase.id, total_price: 10.00)
      create(:purchase_item, purchase_id: purchase.id, total_price: 9.98)
      assert_in_delta 19.98, purchase.total_cost
    end

    should 'be correct for no items' do
      purchase = create(:purchase)
      assert_in_delta 0, purchase.total_cost
    end
  end
end
