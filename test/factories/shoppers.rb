FactoryGirl.define do
  factory :shopper do
    sequence(:email) { |n| "person#{n}@example.com" }
    password {'123123123'}
    password_confirmation {'123123123'}
    confirmed_at Time.current
  end
end
