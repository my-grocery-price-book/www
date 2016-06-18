# == Schema Information
#
# Table name: price_books
#
#  id                              :integer          not null, primary key
#  _deprecated_shopper_id          :integer
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  name                            :string           default("My Price Book"), not null
#  _deprecated_shopper_id_migrated :boolean          default(FALSE), not null
#  region_codes                    :string           default([]), is an Array
#  store_ids                       :integer          default([]), is an Array
#

require 'test_helper'

describe PriceBook do
  def add_page!(price_book, attrs)
    PriceBook::Page.create!(attrs.merge(book: price_book))
  end

  describe 'Defaults' do
    it 'has a default name for a price book' do
      PriceBook.new.name.must_equal('My Price Book')
    end
  end

  describe 'Validation' do
    it 'can create a new book' do
      book = PriceBook.create!(name: 'A Price Book', shopper: create_shopper)
      book.name.must_equal('A Price Book')
    end

    it 'requires name' do
      book = PriceBook.new(name: '')
      book.save
      book.errors[:name].wont_be_empty
    end
  end

  describe '#default_for_shopper' do
    let(:shopper) { create_shopper }
    let(:default_pages) do
      %w(Apples Bread Cabbage Cheese Chicken Soda Eggs Flour Maize Margarine Milk
         Mince Rice Sugar Tea Coffee)
    end

    it 'creates a new book' do
      book = PriceBook.default_for_shopper(shopper)
      book.reload
      book.must_be :persisted?
    end

    it 'builds default_pages for new book' do
      book = PriceBook.default_for_shopper(shopper)
      book.reload
      PriceBook::Page.for_book(book).map(&:name).sort.must_equal(default_pages.sort)
    end

    it 'wont add pages for existing book' do
      PriceBook.create!(shopper: shopper)
      book = PriceBook.default_for_shopper(shopper)
      book.reload
      PriceBook::Page.for_book(book).map(&:name).must_equal([])
    end
  end

  describe '#destroy' do
    subject { PriceBook.create!(shopper: create_shopper) }

    it 'allows to destroy' do
      subject.destroy
      -> { subject.reload }.must_raise(ActiveRecord::RecordNotFound)
    end

    it 'allows to destroy when pages exist' do
      page = add_page!(subject, name: 'Soda', category: 'Drinks', unit: 'Liters')
      subject.destroy
      -> { page.reload }.must_raise(ActiveRecord::RecordNotFound)
      -> { subject.reload }.must_raise(ActiveRecord::RecordNotFound)
    end
  end

  describe '#to_s' do
    it 'renders saved' do
      PriceBook.create!(shopper: create_shopper).to_s
    end

    it 'renders unsaved' do
      PriceBook.new.to_s
    end
  end
end
