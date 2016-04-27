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
end
