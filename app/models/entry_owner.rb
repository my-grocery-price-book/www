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
  belongs_to :shopper

  def price_entry_product_name
    price_entry.product_name
  end

  # @param [Shopper] shopper
  # @param [PriceEntry] entry
  def self.can_update?(shopper:, entry:)
    EntryOwner.where(shopper_id: shopper.id, price_entry_id: entry.id).any?
  end

  # @param [Shopper] shopper
  # @return [Array<String>]
  def self.local_suggestions(shopper:)
    entry_owners = includes(:price_entry).where(shopper_id: shopper.id).order('id DESC').limit(1000)
    suggestions = entry_owners.collect do |entry|
      entry.price_entry_product_name
    end
    suggestions.sort!
    suggestions.uniq!
    suggestions
  end

  # @param [Shopper] shopper
  # @param [PriceEntry] entry
  def self.create_for!(shopper:, entry:)
    create!(shopper_id: shopper.id, price_entry_id: entry.id)
  end

  # @param [Shopper] shopper
  # @return [PriceEntry]
  def self.new_entry_for_shopper(shopper)
    entries = entries_for_shopper(shopper)
    entries = entries.where('price_entries.created_at >= ?', 1.hour.ago)
    entry = entries.last || PriceEntry.new(date_on: Date.current)
    PriceEntry.new(date_on: entry.date_on,
                   store_id: entry.store_id,
                   amount: 1)
  end

  # @param [Shopper] shopper
  # @return [Array<PriceEntry>]
  def self.entries_for_shopper(shopper)
    PriceEntry.joins(:entry_owner).where(entry_owners: { shopper_id: shopper.id })
  end

  # @param [Shopper] shopper
  # @param [String,Integer] id
  # @return [PriceEntry]
  def self.find_entry_for_shopper(shopper, id:)
    entries_for_shopper(shopper).find(id)
  end
end
