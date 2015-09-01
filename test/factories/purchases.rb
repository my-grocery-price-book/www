# == Schema Information
#
# Table name: purchases
#
#  id           :integer          not null, primary key
#  purchased_on :date
#  store        :string
#  location     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  shopper_id   :integer
#  completed_at :datetime
#

FactoryGirl.define do
  factory :purchase do
    sequence(:purchased_on) { |n| (Date.new(2000, 12, 31) + n.days).to_s }
    shopper
  end
end
