FactoryGirl.define do
  factory :regular_item do
    sequence(:name) { |n| "item #{n}" }
    category 'Items'
    shopper
  end
end
