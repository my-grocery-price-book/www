# == Schema Information
#
# Table name: shopper_api_keys
#
#  id         :integer          not null, primary key
#  shopper_id :integer          not null
#  api_key    :string           not null
#  api_root   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :shopper_api_key do
    shopper_id 1
    api_key 'a'
    api_root 'http://www.example.com'
  end
end
