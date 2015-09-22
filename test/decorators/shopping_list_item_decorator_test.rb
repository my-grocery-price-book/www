require 'test_helper'

describe ShoppingListItemDecorator do
  describe 'display_name' do
    it 'returns "#{amount} #{unit} #{name}"' do
      item = ShoppingList::Item.new(amount: 1, unit: 'ml', name: 'water').extend(ShoppingListItemDecorator)
      item.display_name.must_equal('1 ml water')
    end

    it 'returns "#{amount} #{unit}" when name in unit' do
      item = ShoppingList::Item.new(amount: 1, unit: 'apples', name: 'apple').extend(ShoppingListItemDecorator)
      item.display_name.must_equal('1 apples')
    end
  end
end
