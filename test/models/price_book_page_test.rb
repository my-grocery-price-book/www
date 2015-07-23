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

  describe 'Class Methods' do
    subject {PriceBookPage}

    describe 'update_product_for_shopper!' do
      before do
        @shopper = create(:shopper)
      end

      it 'creates a new item with product correct info' do
        subject.update_product_for_shopper!(
          @shopper,
          product_brand_name: 'Coke Lite',
          regular_name: 'Soda',
          category: 'Drinks',
          package_unit: 'ml'
        )
        last_attributes = subject.last.attributes.except('id', 'created_at', 'updated_at')
        last_attributes.must_equal('name' => 'Soda',
                                   'category' => 'Drinks',
                                   'unit' => 'ml',
                                   'product_names' => ['Coke Lite'],
                                   'shopper_id' => @shopper.id)
      end

      it 'adds the product_name to existing item' do
        current_item = create(:price_book_page,
                              shopper: @shopper,
                              name: 'Soda',
                              category: 'Drinks',
                              unit: 'ml',
                              product_names: ['Coke Lite'])
        subject.update_product_for_shopper!(
          @shopper,
          product_brand_name: 'Fanta',
          regular_name: 'Soda',
          category: 'Drinks',
          package_unit: 'ml'
        )
        current_item.reload
        last_attributes = current_item.attributes.except('id', 'created_at', 'updated_at')
        last_attributes.must_equal('name' => 'Soda',
                                   'category' => 'Drinks',
                                   'unit' => 'ml',
                                   'product_names' => ['Coke Lite', 'Fanta'],
                                   'shopper_id' => @shopper.id)
      end

      it 'ignore product_name already on item' do
        current_item = create(:price_book_page,
                              shopper: @shopper,
                              name: 'Soda',
                              category: 'Drinks',
                              unit: 'ml',
                              product_names: ['Coke Lite'])
        subject.update_product_for_shopper!(
          @shopper,
          product_brand_name: 'Coke Lite',
          regular_name: 'Soda',
          category: 'Drinks',
          package_unit: 'ml',
        )
        current_item.reload
        last_attributes = current_item.attributes.except('id', 'created_at', 'updated_at')
        last_attributes.must_equal('name' => 'Soda',
                                   'category' => 'Drinks',
                                   'unit' => 'ml',
                                   'product_names' => ['Coke Lite'],
                                   'shopper_id' => @shopper.id)
      end
    end
  end
end
