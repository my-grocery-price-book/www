# == Schema Information
#
# Table name: shopping_lists
#
#  id            :integer          not null, primary key
#  shopper_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  title         :string
#  price_book_id :integer
#

require 'test_helper'

describe ShoppingList do
  describe 'Validation' do
    it 'requires price_book_id' do
      ShoppingList.create.errors[:price_book_id].wont_be_empty
    end
  end
end
