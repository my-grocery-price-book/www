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
  test 'total_cost should be correct' do
    purchase = purchases(:test_total_cost)
    assert_in_delta 19.98, purchase.total_cost
  end

  test 'total_cost should be correct for no items' do
    purchase = purchases(:test_total_cost_no_items)
    assert_in_delta 0, purchase.total_cost
  end
end
