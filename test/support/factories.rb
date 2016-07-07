# @param [Hash] shopper_args
# @return [Shopper]
def create_shopper(shopper_args = {})
  FactoryGirl.create(:shopper, shopper_args)
end

# @param [PriceBook::Page] page
# @param [String] store_name
# @param [String] location
# @param [Hash<String>] entry_args
# @return [PriceEntry]
def add_new_entry_to_page(page, store_name: 'Checkers', location: 'George Mall', **entry_args)
  store = Store.create(name: store_name, location: location, region_code: 'ZAF-WC')
  entry = PriceEntry.create!(
    entry_args.reverse_merge(date_on: Date.current, store: store, product_name: 'Coke',
                             amount: 1, package_size: 340, package_unit: page.unit, total_price: 8)
  )
  page.add_product_name!(entry.product_name)
  page.add_store_to_book!(store)
  entry
end
