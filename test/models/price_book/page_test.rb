# frozen_string_literal: true

# == Schema Information
#
# Table name: price_book_pages
#
#  old_id            :integer
#  name              :string
#  category          :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  product_names     :text             default([]), is an Array
#  unit              :string
#  old_price_book_id :integer
#  id                :uuid             not null, primary key
#  price_book_id     :uuid
#

require 'test_helper'

describe PriceBook::Page do
  let(:price_book) { PriceBook.create!(shopper: create_shopper) }

  describe 'Validation' do
    it 'can create a new page' do
      page = PriceBook::Page.create!(book: price_book, name: 'Soda', category: 'Drinks', unit: 'Liters')
      _(page).must_be :persisted?
    end

    it 'requires name' do
      _(PriceBook::Page.create.errors[:name]).wont_be_empty
    end

    it 'requires category' do
      _(PriceBook::Page.create.errors[:category]).wont_be_empty
    end

    it 'requires unit' do
      _(PriceBook::Page.create.errors[:unit]).wont_be_empty
    end

    it 'requires price_book_id when updating' do
      page = PriceBook::Page.create!(book: price_book, name: 'Soda', category: 'Drinks', unit: 'Liters')
      page.price_book_id = nil
      page.valid?
      _(page.errors[:price_book_id]).wont_be_empty
    end

    it 'require a uniq name per unit and book' do
      PriceBook::Page.create!(book: price_book, name: 'Soda', category: 'Drinks', unit: 'Liters')
      page = PriceBook::Page.create(book: price_book, name: 'Soda', category: 'Drinks', unit: 'Liters')
      _(page.errors[:name]).wont_be_empty
    end

    it 'allows a same name in another unit and book' do
      PriceBook::Page.create!(book: price_book, name: 'Soda', category: 'Drinks', unit: 'Liters')
      page = PriceBook::Page.create(book: price_book, name: 'Soda', category: 'Drinks', unit: 'Cans')
      _(page).must_be :persisted?
    end
  end

  describe 'creating' do
    subject { PriceBook::Page.new(name: 'Soda', category: 'Drinks', unit: 'Liters', book: price_book) }

    it 'saves unique product_names' do
      subject.product_names = ['Coke Lite', 'Fanta', 'Coke Lite']
      subject.save!
      _(subject.product_names).must_equal(['Coke Lite', 'Fanta'])
    end
  end

  describe 'updating' do
    subject { PriceBook::Page.create!(book: price_book, name: 'Soda', category: 'Drinks', unit: 'Liters') }

    it 'saves unique product_names' do
      subject.update!(product_names: ['Sasko Bread', 'Woolworths Bread', 'Woolworths Bread'])
      _(subject.product_names).must_equal(['Sasko Bread', 'Woolworths Bread'])
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
      _(PriceBook::Page.find_page!(@book, page.id).info).must_equal(name: 'Soda', category: 'Drinks', unit: 'Liters')
    end

    it 'raises error if cant find' do
      add_page!(name: 'Soda', category: 'Drinks', unit: 'Liters')
      _(-> { PriceBook::Page.find_page!(@book, '0') }).must_raise(ActiveRecord::RecordNotFound)
    end
  end

  describe 'best_entry' do
    subject { PriceBook::Page.create!(book: price_book, name: 'Soda', category: 'Drinks', unit: 'Liters') }

    it 'find no entries' do
      _(subject.best_entry).must_be_nil
    end

    it 'find no entries' do
      entry = add_entry(page: subject)
      _(subject.best_entry).must_equal(entry)
    end

    describe 'context with item' do
      before do
        expensive_entry = FactoryGirl.create(:price_entry, amount: 1, package_size: 1, total_price: 2,
                                                           package_unit: subject.unit)
        add_entry(page: subject, entry: expensive_entry)
      end

      it 'find cheaper entry' do
        cheap_entry = FactoryGirl.create(:price_entry, amount: 1, package_size: 1, total_price: 1,
                                                       package_unit: subject.unit)
        add_entry(page: subject, entry: cheap_entry)

        _(subject.best_entry).must_equal(cheap_entry)
      end

      it 'find cheapest price_per_unit entry' do
        cheap_entry = FactoryGirl.create(:price_entry, amount: 3, package_size: 1, total_price: 4,
                                                       package_unit: subject.unit)
        add_entry(page: subject, entry: cheap_entry)

        _(subject.best_entry).must_equal(cheap_entry)
      end
    end
  end
end
