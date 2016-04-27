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

class EntryOwner < ActiveRecord::Base
  validates :price_entry_id, :shopper_id, presence: true
  belongs_to :price_entry
end
