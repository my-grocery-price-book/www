# == Schema Information
#
# Table name: price_book_pages
#
#  id            :integer          not null, primary key
#  name          :string
#  category      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  shopper_id    :integer
#  product_names :text             default([]), is an Array
#  unit          :string
#

FactoryGirl.define do
  factory :price_book_page do
    sequence(:name) { |n| "item #{n}" }
    category 'Items'
    unit 'items'
    shopper
  end
end
