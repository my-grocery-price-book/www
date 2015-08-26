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
  def add_page!(price_book, attrs)
    price_book.pages.create!(attrs)
  end

  describe 'Validation' do
    it 'can create a new page' do
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

  describe 'destroy' do
    subject{ PriceBook.create!(shopper: create(:shopper)) }

    it 'allows to destroy' do
      subject.destroy
      lambda{subject.reload}.must_raise(ActiveRecord::RecordNotFound)
    end

    it 'allows to destroy when pages exist' do
      page = add_page!(subject,name: 'Soda', category: 'Drinks', unit: 'Liters')
      subject.destroy
      lambda{page.reload}.must_raise(ActiveRecord::RecordNotFound)
      lambda{subject.reload}.must_raise(ActiveRecord::RecordNotFound)
    end
  end

  describe 'find_page!' do
    subject{ PriceBook.create!(shopper: create(:shopper)) }

    it 'can find a page' do
      add_page!(subject,name: 'Soda', category: 'Drinks', unit: 'Liters')
      subject.find_page!('drinks_liters_soda').info.must_equal(name: 'Soda', category: 'Drinks', unit: 'Liters')
    end

    it 'returns nil for unknown page' do
      add_page!(subject,name: 'Soda', category: 'Drinks', unit: 'Liters')
      lambda { subject.find_page!('unknown') }.must_raise(ActiveRecord::RecordNotFound)
    end
  end

  describe 'search_pages' do
    subject{ PriceBook.create!(shopper: create(:shopper)) }

    it 'returns all pages with nil term' do
      add_page!(subject,name: 'Soda', category: 'Drinks', unit: 'Liters')
      add_page!(subject,name: 'Eggs', category: 'Fresh', unit: 'Dozens')
      pages = subject.search_pages(nil)
      pages.map(&:name).must_equal(%w(Soda Eggs))
    end

    it 'returns all pages with blank term' do
      add_page!(subject,name: 'Soda', category: 'Drinks', unit: 'Liters')
      add_page!(subject,name: 'Eggs', category: 'Fresh', unit: 'Dozens')
      pages = subject.search_pages('')
      pages.map(&:name).must_equal(%w(Soda Eggs))
    end

    it 'returns all pages that match start string' do
      add_page!(subject,name: 'Soda', category: 'Drinks', unit: 'Liters')
      add_page!(subject,name: 'Eggs', category: 'Fresh', unit: 'Dozens')
      pages = subject.search_pages('Eg')
      pages.map(&:name).must_equal(%w(Eggs))
    end

    it 'returns all pages that match end of string' do
      add_page!(subject,name: 'Soda', category: 'Drinks', unit: 'Liters')
      add_page!(subject,name: 'Eggs', category: 'Fresh', unit: 'Dozens')
      pages = subject.search_pages('da')
      pages.map(&:name).must_equal(%w(Soda))
    end

    it 'returns all pages that match string' do
      add_page!(subject,name: 'Soda', category: 'Drinks', unit: 'Liters')
      add_page!(subject,name: 'Eggs', category: 'Fresh', unit: 'Dozens')
      pages = subject.search_pages('s')
      pages.map(&:name).must_equal(%w(Soda Eggs))
    end
  end
end
