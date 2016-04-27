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
  describe 'Validation' do
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
  end
end
