# == Schema Information
#
# Table name: price_entries
#
#  id           :integer          not null, primary key
#  date_on      :date             not null
#  store_id     :integer
#  product_name :string           not null
#  amount       :integer          not null
#  package_size :integer          not null
#  package_unit :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  total_price  :money            not null
#

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
