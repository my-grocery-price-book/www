FactoryGirl.define do
  factory :shopper_api_key do
    shopper_id 1
    api_key 'a'
    api_root 'http://www.example.com'
  end
end