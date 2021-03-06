# frozen_string_literal: true

json.call(entry, :id, :amount, :store_name, :location,
          :package_size, :package_unit, :product_name, :currency_symbol)
json.total_price safe_float_for_json(entry.total_price)
json.price_per_unit safe_float_for_json(entry.price_per_unit)
json.price_per_package safe_float_for_json(entry.price_per_package)
