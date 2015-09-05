# == Schema Information
#
# Table name: price_books
#
#  id         :integer          not null, primary key
#  shopper_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :price_book do
    shopper
  end
end
