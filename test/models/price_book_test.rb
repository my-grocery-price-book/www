# == Schema Information
#
# Table name: price_books
#
#  id         :integer          not null, primary key
#  shopper_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

describe PriceBook do
  describe 'Validation' do
    it 'can create a new price book' do
      PriceBook.create!(shopper: create(:shopper))
    end

    it 'requires shopper_id' do
      PriceBook.create.errors[:shopper_id].wont_be_empty
    end

    it 'requires unique shopper' do
      shopper = create(:shopper)
      PriceBook.create!(shopper: shopper)
      PriceBook.create(shopper: shopper).errors[:shopper_id].wont_be_empty
    end

    it 'allows different shoppers' do
      PriceBook.create!(shopper: create(:shopper))
      PriceBook.create(shopper: create(:shopper)).errors[:shopper_id].must_be_empty
    end
  end

  describe 'find_page!' do
    subject{ PriceBook.create!(shopper: create(:shopper)) }

    it 'can find a page' do
      subject.add_page!(name: 'Soda', category: 'Drinks', unit: 'Liters')
      subject.find_page!('drinks_liters_soda').info.must_equal(name: 'Soda', category: 'Drinks', unit: 'Liters')
    end

    it 'returns nil for unknown page' do
      subject.add_page!(name: 'Soda', category: 'Drinks', unit: 'Liters')
      lambda { subject.find_page!('unknown') }.must_raise(ActiveRecord::RecordNotFound)
    end
  end

  describe 'update_page!' do
    subject{ PriceBook.create!(shopper: create(:shopper)) }

    it 'can update a page' do
      subject.add_page!(name: 'Soda', category: 'Drinks', unit: 'Liters')
      subject.update_page!('drinks_liters_soda', name: 'Gas drinks')
      subject.pages.map(&:info).must_equal([{name: 'Gas drinks', category: 'Drinks', unit: 'Liters'}])
    end

    it 'does not modify other pages' do
      subject.add_page!(name: 'Soda', category: 'Drinks', unit: 'Liters')
      subject.add_page!(name: 'Eggs', category: 'Fresh', unit: 'Dozens')
      subject.update_page!('drinks_liters_soda', name: 'Gas')
      subject.pages.map(&:info).must_equal([{name: 'Gas', category: 'Drinks', unit: 'Liters'},
                                            {name: 'Eggs', category: 'Fresh', unit: 'Dozens'}])
    end
  end

  describe 'add_page!' do
    subject{ PriceBook.create!(shopper: create(:shopper)) }

    it 'can add a single page' do
      subject.add_page!(name: 'Soda', category: 'Drinks', unit: 'Liters')
      subject.pages.map(&:info).must_equal([{name: 'Soda', category: 'Drinks', unit: 'Liters'}])
    end

    it 'wont return pages from other price books' do
      other_price_book = PriceBook.create!(shopper: create(:shopper))
      other_price_book.add_page!(name: 'Soda', category: 'Drinks', unit: 'Liters')
      subject.pages.map(&:info).must_equal([])
    end

    it 'ignores duplicates' do
      subject.add_page!(name: 'Soda', category: 'Drinks', unit: 'Liters')
      subject.add_page!(name: 'Soda', category: 'Drinks', unit: 'Liters')
      subject.pages.map(&:info).must_equal([{name: 'Soda', category: 'Drinks', unit: 'Liters'}])
    end

    it 'can create same name with different unit' do
      subject.add_page!(name: 'Soda', category: 'Drinks', unit: 'Liters')
      subject.add_page!(name: 'Soda', category: 'Drinks', unit: 'Cans')
      subject.pages.map(&:info).must_equal([{name: 'Soda', category: 'Drinks', unit: 'Liters'},
                                            {name: 'Soda', category: 'Drinks', unit: 'Cans'}])
    end
  end

  describe 'search_pages' do
    subject{ PriceBook.create!(shopper: create(:shopper)) }

    it 'returns all pages with nil term' do
      subject.add_page!(name: 'Soda', category: 'Drinks', unit: 'Liters')
      subject.add_page!(name: 'Eggs', category: 'Fresh', unit: 'Dozens')
      pages = subject.search_pages(nil)
      pages.map(&:name).must_equal(%w(Soda Eggs))
    end

    it 'returns all pages with blank term' do
      subject.add_page!(name: 'Soda', category: 'Drinks', unit: 'Liters')
      subject.add_page!(name: 'Eggs', category: 'Fresh', unit: 'Dozens')
      pages = subject.search_pages('')
      pages.map(&:name).must_equal(%w(Soda Eggs))
    end

    it 'returns all pages that match start string' do
      subject.add_page!(name: 'Soda', category: 'Drinks', unit: 'Liters')
      subject.add_page!(name: 'Eggs', category: 'Fresh', unit: 'Dozens')
      pages = subject.search_pages('Eg')
      pages.map(&:name).must_equal(%w(Eggs))
    end

    it 'returns all pages that match end of string' do
      subject.add_page!(name: 'Soda', category: 'Drinks', unit: 'Liters')
      subject.add_page!(name: 'Eggs', category: 'Fresh', unit: 'Dozens')
      pages = subject.search_pages('da')
      pages.map(&:name).must_equal(%w(Soda))
    end

    it 'returns all pages that match string' do
      subject.add_page!(name: 'Soda', category: 'Drinks', unit: 'Liters')
      subject.add_page!(name: 'Eggs', category: 'Fresh', unit: 'Dozens')
      pages = subject.search_pages('s')
      pages.map(&:name).must_equal(%w(Soda Eggs))
    end
  end
end
