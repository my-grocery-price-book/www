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

class EntryOwner < ApplicationRecord
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
  # @return [Set<String>]
  def self.name_suggestions(shopper:, query: nil)
    entry_owners = includes(:price_entry).joins(:price_entry).where(shopper_id: shopper.id).limit(1000)
    entry_owners = entry_owners.where('price_entries.created_at > ?', 6.months.ago)
    entry_owners = entry_owners.where('price_entries.product_name ILIKE ?', "%#{query}%")
    suggestions = Set.new
    entry_owners.each do |entry|
      suggestions.add entry.price_entry_product_name
    end
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
