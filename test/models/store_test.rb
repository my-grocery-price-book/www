# == Schema Information
#
# Table name: stores
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  location   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

describe Store do
  describe 'Validation' do
    it 'requires name' do
      Store.create.errors[:name].wont_be_empty
    end

    it 'requires price_book_id' do
      Store.create.errors[:location].wont_be_empty
    end
  end
end
