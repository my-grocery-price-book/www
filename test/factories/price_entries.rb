# frozen_string_literal: true

# == Schema Information
#
# Table name: price_entries
#
#  old_id       :integer
#  date_on      :date             not null
#  old_store_id :integer
#  product_name :string           not null
#  amount       :integer          not null
#  package_size :integer          not null
#  package_unit :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  total_price  :money            not null
#  id           :uuid             not null, primary key
#  store_id     :uuid
#

FactoryGirl.define do
  factory :price_entry do
    date_on { rand(365).days.ago }
    product_name { "Product #{Time.current.to_i}" }
    amount { rand(1..100) }
    package_size { rand(1..100) }
    package_unit { PriceBook::Page::UNITS.sample }
    total_price { rand(1..100) }
    store
  end
end
