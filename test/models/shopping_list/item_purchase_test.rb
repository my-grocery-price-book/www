# frozen_string_literal: true
# == Schema Information
#
# Table name: shopping_list_item_purchases
#
#  old_id                    :integer
#  old_shopping_list_item_id :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  id                        :uuid             not null, primary key
#  shopping_list_item_id     :uuid
#

require 'test_helper'

describe ShoppingList::ItemPurchase do
end
