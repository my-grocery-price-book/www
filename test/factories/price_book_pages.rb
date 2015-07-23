FactoryGirl.define do
  factory :price_book_page do
    sequence(:name) { |n| "item #{n}" }
    category 'Items'
    unit 'items'
    shopper
  end
end
