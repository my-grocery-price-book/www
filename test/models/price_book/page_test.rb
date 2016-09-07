# == Schema Information
#
# Table name: price_book_pages
#
#  old_id        :integer
#  name          :string
#  category      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  product_names :text             default([]), is an Array
#  unit          :string
#  price_book_id :integer
#  id            :uuid             not null, primary key
#

require 'test_helper'

describe PriceBook::Page do
  let(:price_book) { PriceBook.create!(shopper: create_shopper) }

  describe 'Validation' do
    it 'can create a new page' do
      page = PriceBook::Page.create!(book: price_book, name: 'Soda', category: 'Drinks', unit: 'Liters')
      page.must_be :persisted?
    end

    it 'requires name' do
      PriceBook::Page.create.errors[:name].wont_be_empty
    end

    it 'requires category' do
      PriceBook::Page.create.errors[:category].wont_be_empty
    end

    it 'requires unit' do
      PriceBook::Page.create.errors[:unit].wont_be_empty
    end

    it 'requires price_book_id when updating' do
      page = PriceBook::Page.create!(book: price_book, name: 'Soda', category: 'Drinks', unit: 'Liters')
      page.price_book_id = nil
      page.valid?
      page.errors[:price_book_id].wont_be_empty
    end

    it 'require a uniq name per unit and book' do
      PriceBook::Page.create!(book: price_book, name: 'Soda', category: 'Drinks', unit: 'Liters')
      page = PriceBook::Page.create(book: price_book, name: 'Soda', category: 'Drinks', unit: 'Liters')
      page.errors[:name].wont_be_empty
    end

    it 'allows a same name in another unit and book' do
      PriceBook::Page.create!(book: price_book, name: 'Soda', category: 'Drinks', unit: 'Liters')
      page = PriceBook::Page.create(book: price_book, name: 'Soda', category: 'Drinks', unit: 'Cans')
      page.must_be :persisted?
    end
  end

  describe 'creating' do
    subject { PriceBook::Page.new(name: 'Soda', category: 'Drinks', unit: 'Liters', book: price_book) }

    it 'saves unique product_names' do
      subject.product_names = ['Coke Lite', 'Fanta', 'Coke Lite']
      subject.save!
      subject.product_names.must_equal(['Coke Lite', 'Fanta'])
    end
  end

  describe 'updating' do
    subject { PriceBook::Page.create!(book: price_book, name: 'Soda', category: 'Drinks', unit: 'Liters') }

    it 'saves unique product_names' do
      subject.update!(product_names: ['Sasko Bread', 'Woolworths Bread', 'Woolworths Bread'])
      subject.product_names.must_equal(['Sasko Bread', 'Woolworths Bread'])
    end
  end

  describe 'find_page!' do
    def add_page!(attrs)
      PriceBook::Page.create!(attrs.merge(book: @book))
    end

    before :each do
      @book = PriceBook.create!(shopper: create_shopper)
    end

    it 'can find a page' do
      page = add_page!(name: 'Soda', category: 'Drinks', unit: 'Liters')
      PriceBook::Page.find_page!(@book, page.id).info.must_equal(name: 'Soda', category: 'Drinks', unit: 'Liters')
    end

    it 'raises error if cant find' do
      add_page!(name: 'Soda', category: 'Drinks', unit: 'Liters')
      -> { PriceBook::Page.find_page!(@book, '0') }.must_raise(ActiveRecord::RecordNotFound)
    end
  end

  describe 'best_entry' do
    subject { PriceBook::Page.create!(book: price_book, name: 'Soda', category: 'Drinks', unit: 'Liters') }

    it 'find no entries' do
      subject.best_entry.must_be_nil
    end

    it 'find no entries' do
      entry = add_new_entry_to_page(subject)
      subject.best_entry.must_equal(entry)
    end

    it 'find cheaper entry' do
      add_new_entry_to_page(subject, amount: 1, package_size: 1, total_price: 2)
      entry = add_new_entry_to_page(subject, amount: 1, package_size: 1, total_price: 1)
      subject.best_entry.must_equal(entry)
    end

    it 'find cheapest price_per_unit entry' do
      add_new_entry_to_page(subject, amount: 1, package_size: 1, total_price: 2)
      entry = add_new_entry_to_page(subject, amount: 3, package_size: 1, total_price: 4)
      subject.best_entry.must_equal(entry)
    end
  end
end
