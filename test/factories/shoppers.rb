FactoryGirl.define do
  factory :shopper do
    password '123123123'
    password_confirmation '123123123'
    sequence :email do |n|
      "person#{n}@example.com"
    end
    confirmed_at Time.current
  end
end
