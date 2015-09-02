# == Schema Information
#
# Table name: price_book_pages
#
#  id            :integer          not null, primary key
#  name          :string
#  category      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  product_names :text             default([]), is an Array
#  unit          :string
#  price_book_id :integer
#

FactoryGirl.define do
  factory :price_book_page, class: 'PriceBook::Page' do
    sequence(:name) { |n| "item#{n}" }
    category 'Fresh'
    unit 'grams'
    price_book_id { create(:price_book).id }
  end
end
