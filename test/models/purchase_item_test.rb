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
  # test "the truth" do
  #   assert true
  # end
end
