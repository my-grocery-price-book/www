# == Schema Information
#
# Table name: price_book_pages
#
#  id            :integer          not null, primary key
#  name          :string
#  category      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  product_names :text             default([]), is an Array
#  unit          :string
#  price_book_id :integer
#

require 'test_helper'

describe PriceBook::Page do
  let(:price_book) { PriceBook.create!(shopper: create_shopper) }

  describe 'Validation' do
    it 'can create a new page' do
      page = price_book.pages.create(name: 'Soda', category: 'Drinks', unit: 'Liters')
      page.must_be :persisted?
    end

    it 'requires name' do
      price_book.pages.create.errors[:name].wont_be_empty
    end

    it 'requires category' do
      price_book.pages.create.errors[:category].wont_be_empty
    end

    it 'requires unit' do
      price_book.pages.create.errors[:unit].wont_be_empty
    end

    it 'requires price_book_id when updating' do
      page = price_book.pages.create!(name: 'Soda', category: 'Drinks', unit: 'Liters')
      page.price_book_id = nil
      page.valid?
      page.errors[:price_book_id].wont_be_empty
    end

    it 'require a uniq name per unit and book' do
      price_book.pages.create(name: 'Soda', category: 'Drinks', unit: 'Liters')
      page = price_book.pages.create(name: 'Soda', category: 'Drinks', unit: 'Liters')
      page.errors[:name].wont_be_empty
    end

    it 'allows a same name in another unit and book' do
      price_book.pages.create(name: 'Soda', category: 'Drinks', unit: 'Liters')
      page = price_book.pages.create(name: 'Soda', category: 'Drinks', unit: 'Cans')
      page.must_be :persisted?
    end
  end

  describe 'creating' do
    subject { PriceBook::Page.new(name: 'Soda', category: 'Drinks', unit: 'Liters') }

    it 'saves unique product_names' do
      subject.product_names = ['Coke Lite', 'Fanta', 'Coke Lite']
      subject.save
      subject.product_names.must_equal(['Coke Lite', 'Fanta'])
    end
  end

  describe 'updating' do
    subject { price_book.pages.create!(name: 'Soda', category: 'Drinks', unit: 'Liters') }

    it 'saves unique product_names' do
      subject.update(product_names: ['Sasko Bread', 'Woolworths Bread', 'Woolworths Bread'])
      subject.product_names.must_equal(['Sasko Bread', 'Woolworths Bread'])
    end
  end
end
