FactoryGirl.define do
  factory :purchase_item do
    sequence(:purchase_id)
    sequence(:product_brand_name) { |n| "item #{n}" }
    package_size 1
    quantity 1
    total_price 1
  end
end
