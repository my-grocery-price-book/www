json.call(entry, :id, :total_price, :amount, :store_name, :location,
          :package_size, :package_unit, :product_name, :currency_symbol)
json.price_per_unit entry.price_per_unit.to_f # make sure json formats it as a float and not a string
json.price_per_package entry.price_per_package.to_f # make sure json formats it as a float and not a string
