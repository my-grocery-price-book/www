# frozen_string_literal: true
# @param [Hash] shopper_args
# @return [Shopper]
def create_shopper(shopper_args = {})
  FactoryGirl.create(:shopper, shopper_args)
end

class PageEntryAdder < SimpleDelegator
  # @param [Shopper] shopper
  # @param [Entry] entry
  # @return [Entry]
  def add_entry(shopper: nil, entry: nil)
    entry ||= FactoryGirl.create(:price_entry, package_unit: unit)
    check_entry_unit_match(entry.package_unit)
    EntryOwner.create_for!(shopper: shopper, entry: entry) if shopper
    new_entry_added(entry)
    add_store_to_book(entry.store)
    entry
  end

  private

  def check_entry_unit_match(entry_package_unit)
    if entry_package_unit != unit
      raise StandardError, "page (#{unit}) and entry (#{entry_package_unit}) unit do not match"
    end
  end
end

# @param [PriceBook::Page] page
# @param [PriceEntry, nil] entry
# @param [Shopper, nil] shopper
def add_entry(page:, shopper: nil, entry: nil)
  PageEntryAdder.new(page).add_entry(shopper: shopper, entry: entry)
end
