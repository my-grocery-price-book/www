FactoryGirl.define do
  factory :price_entry do
    date_on Date.current
    product_name 'Coke'
    amount 1
    package_size 340
    package_unit 'milliliters'
    total_price 8
    store
  end
end
