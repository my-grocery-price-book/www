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

describe PriceBookPage do
  describe 'Validation' do
    it 'creates a valid item' do
      PriceBookPage.create!(shopper: create(:shopper),
                            name: 'Potatoes',
                            category: 'Veg',
                            unit: 'KG')
    end

    it 'should have a name' do
      price_book_page = PriceBookPage.create
      price_book_page.errors[:name].wont_be_empty
    end

    it 'should have a category' do
      price_book_page = PriceBookPage.create
      price_book_page.errors[:category].wont_be_empty
    end

    it 'should have a unit' do
      price_book_page = PriceBookPage.create
      price_book_page.errors[:unit].wont_be_empty
    end

    it 'wont be valid if name not uniq per shopper' do
      shopper = create(:shopper)
      PriceBookPage.create!(shopper: shopper, name: 'Potatoes', category: 'Veg', unit: 'KG')
      price_book_page = PriceBookPage.create(shopper: shopper, name: 'Potatoes', category: 'Veg', unit: 'KG')
      price_book_page.errors[:name].wont_be_empty
    end

    it 'should be valid if name uniq per shopper' do
      shopper = create(:shopper)
      PriceBookPage.create!(shopper: shopper, name: 'Potatoes', category: 'Veg', unit: 'KG')
      price_book_page = PriceBookPage.create(shopper: shopper, name: 'Tomatoes', category: 'Veg', unit: 'KG')
      price_book_page.errors[:name].must_be_empty
    end

    it 'should be valid if same name but different shopper' do
      PriceBookPage.create!(shopper: create(:shopper), name: 'Potatoes', category: 'Veg', unit: 'KG')
      price_book_page = PriceBookPage.create(shopper: create(:shopper), name: 'Potatoes', category: 'Veg', unit: 'KG')
      price_book_page.errors[:name].must_be_empty
    end
  end
end
