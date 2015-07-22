# == Schema Information
#
# Table name: price_book_pages
#
#  id         :integer          not null, primary key
#  name       :string
#  category   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  shopper_id :integer
#

require 'test_helper'

class PriceBookPageTest < ActiveSupport::TestCase
  context 'validation' do
    should 'create a valid item' do
      PriceBookPage.create!(shopper: create(:shopper), name: 'Potatoes', category: 'Veg')
    end

    should 'not be valid without a name' do
      price_book_page = PriceBookPage.create
      assert_not_empty price_book_page.errors[:name]
    end

    should 'not be valid without catgeory' do
      price_book_page = PriceBookPage.create
      assert_not_empty price_book_page.errors[:category]
    end

    should 'not be valid if name not uniq per shopper' do
      shopper = create(:shopper)
      PriceBookPage.create!(shopper: shopper, name: 'Potatoes', category: 'Veg')
      price_book_page = PriceBookPage.create(shopper: shopper, name: 'Potatoes', category: 'Veg')
      assert_not_empty price_book_page.errors[:name]
    end

    should 'be valid if name uniq per shopper' do
      shopper = create(:shopper)
      PriceBookPage.create!(shopper: shopper, name: 'Potatoes', category: 'Veg')
      price_book_page = PriceBookPage.create(shopper: shopper, name: 'Tomatoes', category: 'Veg')
      assert_empty price_book_page.errors[:name]
    end

    should 'be valid if same name but different shopper' do
      PriceBookPage.create!(shopper: create(:shopper), name: 'Potatoes', category: 'Veg')
      price_book_page = PriceBookPage.create(shopper: create(:shopper), name: 'Potatoes', category: 'Veg')
      assert_empty price_book_page.errors[:name]
    end
  end
end
