# == Schema Information
#
# Table name: shopping_list_items
#
#  old_id               :integer
#  old_shopping_list_id :integer
#  name                 :string
#  amount               :integer          default(1), not null
#  unit                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  id                   :uuid             not null, primary key
#  shopping_list_id     :uuid
#

require 'test_helper'

class ShoppingList::ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
