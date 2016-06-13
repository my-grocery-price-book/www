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

  def price_entry_product_name
    price_entry.product_name
  end

  # @param [Shopper] shopper
  # @return [Array<String>]
  def self.local_suggestions(shopper:)
    entry_owners = includes(:price_entry).where(shopper_id: shopper.id).order('id DESC').limit(1000)
    suggestions = entry_owners.collect(&:price_entry_product_name)
    suggestions.sort!
    suggestions.uniq!
    suggestions
  end
end
