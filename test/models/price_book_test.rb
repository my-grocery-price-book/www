# frozen_string_literal: true

# == Schema Information
#
# Table name: price_books
#
#  old_id        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  name          :string           default("My Price Book"), not null
#  region_codes  :string           default([]), is an Array
#  old_store_ids :integer          default([]), is an Array
#  id            :uuid             not null, primary key
#  store_ids     :uuid             default([]), is an Array
#

require 'test_helper'

describe PriceBook do
  describe 'Defaults' do
    it 'has a default name for a price book' do
      _(PriceBook.new.name).must_equal('My Price Book')
    end
  end

  describe 'Validation' do
    it 'can create a new book' do
      book = PriceBook.create!(name: 'A Price Book', shopper: create_shopper)
      _(book.name).must_equal('A Price Book')
    end

    it 'requires name' do
      book = PriceBook.new(name: '')
      book.save
      _(book.errors[:name]).wont_be_empty
    end
  end

  describe '#default_for_shopper' do
    let(:shopper) { create_shopper }

    let(:default_pages) do
      %w[Apples Bread Cabbage Cheese Chicken Soda Eggs Flour Maize Margarine Milk
         Mince Rice Sugar Tea Coffee]
    end

    it 'creates a new book' do
      book = PriceBook.default_for_shopper(shopper)
      book.reload
      _(book).must_be :persisted?
    end

    it 'builds default_pages for new book' do
      book = PriceBook.default_for_shopper(shopper)
      book.reload
      _(PriceBook::Page.for_book(book).map(&:name).sort).must_equal(default_pages.sort)
    end

    it 'wont add pages for existing book' do
      PriceBook.create!(shopper: shopper)
      book = PriceBook.default_for_shopper(shopper)
      book.reload
      _(PriceBook::Page.for_book(book).map(&:name)).must_equal([])
    end
  end

  describe '#destroy' do
    subject { PriceBook.create!(shopper: create_shopper) }

    it 'allows to destroy' do
      subject.destroy
      _(-> { subject.reload }).must_raise(ActiveRecord::RecordNotFound)
    end

    it 'allows to destroy when pages exist' do
      page = FactoryGirl.create(:page, book: subject)
      subject.destroy
      _(-> { page.reload }).must_raise(ActiveRecord::RecordNotFound)
      _(-> { subject.reload }).must_raise(ActiveRecord::RecordNotFound)
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
