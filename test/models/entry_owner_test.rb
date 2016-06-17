# == Schema Information
#
# Table name: entry_owners
#
#  id             :integer          not null, primary key
#  price_entry_id :integer
#  shopper_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

describe EntryOwner do
  describe 'Validation' do
    it 'requires price_entry_id' do
      EntryOwner.create.errors[:price_entry_id].wont_be_empty
    end

    it 'requires shopper_id' do
      EntryOwner.create.errors[:shopper_id].wont_be_empty
    end
  end

  describe '.new_entry_for_shopper(shopper)' do
    let(:subject) { EntryOwner }

    let(:store) { Store.create!(name: 'Test', location: 'Test', region_code: 'ZAR') }

    let(:entry_attributes) do
      { date_on: Date.current, store: store, product_name: 'Fresh Milk',
        amount: 42, package_size: 100, package_unit: 'liters',
        total_price: '199.99' }
    end

    let(:shopper) { Shopper.create(email: 'test@mail.com', password: 'password') }

    describe 'context: no entries in last hour' do
      before :each do
        entry = PriceEntry.create!(entry_attributes.merge(date_on: Date.yesterday,
                                                          created_at: 61.minutes.ago))
        subject.create_for!(shopper: shopper, entry: entry)
      end

      it 'sets amount to 1' do
        entry = subject.new_entry_for_shopper(shopper)
        entry.amount.must_equal(1)
      end

      it 'sets date_on to Date.current' do
        entry = subject.new_entry_for_shopper(shopper)
        entry.date_on.must_equal(Date.current)
      end

      it 'sets store_id to nil' do
        entry = subject.new_entry_for_shopper(shopper)
        entry.store_id.must_be_nil
      end
    end

    describe 'context: entries in last hour' do
      before :each do
        entry = PriceEntry.create!(entry_attributes.merge(date_on: Date.yesterday,
                                                          created_at: 59.minutes.ago))
        subject.create_for!(shopper: shopper, entry: entry)
      end

      it 'sets amount to 1' do
        entry = subject.new_entry_for_shopper(shopper)
        entry.amount.must_equal(1)
      end

      it 'sets date_on to Date.current' do
        entry = subject.new_entry_for_shopper(shopper)
        entry.date_on.must_equal(Date.yesterday)
      end

      it 'sets store to last entry' do
        entry = subject.new_entry_for_shopper(shopper)
        entry.store.must_equal(store)
      end
    end
  end
end
