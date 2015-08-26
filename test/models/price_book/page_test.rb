require 'test_helper'

describe PriceBook::Page do
  let(:price_book){PriceBook.create!(shopper: create(:shopper))}

  describe 'Validation' do
    it 'can create a new page' do
      PriceBook::Page.create(name: 'Soda', category: 'Drinks', unit: 'Liters', price_book_id: price_book.id).must_be :persisted?
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

    it 'requires price_book_id' do
      PriceBook::Page.create.errors[:price_book_id].wont_be_empty
    end

    it 'require a uniq name per unit and book' do
      PriceBook::Page.create(name: 'Soda', category: 'Drinks', unit: 'Liters', price_book_id: price_book.id)
      page = PriceBook::Page.create(name: 'Soda', category: 'Drinks', unit: 'Liters', price_book_id: price_book.id)
      page.errors[:name].wont_be_empty
    end

    it 'allows a same name in another unit and book' do
      PriceBook::Page.create(name: 'Soda', category: 'Drinks', unit: 'Liters', price_book_id: price_book.id)
      PriceBook::Page.create(name: 'Soda', category: 'Drinks', unit: 'Cans', price_book_id: price_book.id).must_be :persisted?
    end
  end

  describe 'creating' do
    subject {PriceBook::Page.new(name: 'Soda', category: 'Drinks', unit: 'Liters', price_book_id: price_book.id)}

    it 'saves unique product_names' do
      subject.product_names = ['Coke Lite', 'Fanta', 'Coke Lite']
      subject.save
      subject.product_names.must_equal(['Coke Lite', 'Fanta'])
    end
  end

  describe 'updating' do
    subject {PriceBook::Page.create!(name: 'Soda', category: 'Drinks', unit: 'Liters', price_book_id: price_book.id)}

    it 'saves unique product_names' do
      subject.update(product_names: ['Sasko Bread', 'Woolworths Bread', 'Woolworths Bread'])
      subject.product_names.must_equal(['Sasko Bread', 'Woolworths Bread'])
    end
  end
end
