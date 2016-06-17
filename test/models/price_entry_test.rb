# == Schema Information
#
# Table name: price_entries
#
#  id           :integer          not null, primary key
#  date_on      :date             not null
#  store_id     :integer
#  product_name :string           not null
#  amount       :integer          not null
#  package_size :integer          not null
#  package_unit :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  total_price  :money            not null
#

require 'test_helper'

describe PriceEntry do
  let(:store) { Store.create!(name: 'Test', location: 'Test', region_code: 'ZAR') }

  let(:default_attributes) do
    { date_on: Date.current, store: store, product_name: 'Fresh Milk',
      amount: 42, package_size: 100, package_unit: 'liters',
      total_price: '199.99' }
  end

  describe 'Validation' do
    it 'creates a valid entry' do
      PriceEntry.create!(default_attributes)
    end

    it 'requires date_on' do
      PriceEntry.create.errors[:date_on].wont_be_empty
    end

    it 'requires product_name' do
      PriceEntry.create.errors[:product_name].wont_be_empty
    end

    it 'requires amount' do
      PriceEntry.create.errors[:amount].wont_be_empty
    end

    it 'requires amount to be positive' do
      PriceEntry.create(amount: 0).errors[:amount].wont_be_empty
    end

    it 'requires package_size' do
      PriceEntry.create.errors[:package_size].wont_be_empty
    end

    it 'requires package_size to be positive' do
      PriceEntry.create(package_size: 0).errors[:package_size].wont_be_empty
    end

    it 'requires package_unit' do
      PriceEntry.create.errors[:package_unit].wont_be_empty
    end

    it 'requires total_price' do
      PriceEntry.create.errors[:total_price].wont_be_empty
    end

    it 'requires total_price to be positive' do
      PriceEntry.create(total_price: 0).errors[:total_price].wont_be_empty
    end

    it 'requires store_id' do
      PriceEntry.create.errors[:store_id].wont_be_empty
    end
  end

  describe '.for_product_names' do
    before do
      @store = Store.create(name: 'Test', location: 'Test', region_code: 'ZAR-WC')
      PriceEntry.create!(date_on: Date.current, store: @store, product_name: 'White Milk',
                         amount: 42, package_size: 100, package_unit: 'liters', total_price: '300.01')
      PriceEntry.create!(date_on: Date.current, store: @store, product_name: 'Yellow Bananas',
                         amount: 42, package_size: 100, package_unit: 'grams', total_price: '200.00')
      PriceEntry.create!(date_on: Date.current, store: @store, product_name: 'Red Apples',
                         amount: 42, package_size: 100, package_unit: 'grams', total_price: '508.66')
    end

    it 'find the product in the correct store' do
      entries = PriceEntry.for_product_names(['Red Apples'], unit: 'grams', store_ids: [@store.id])
      entries.map(&:product_name).must_equal(['Red Apples'])
    end
  end
end
