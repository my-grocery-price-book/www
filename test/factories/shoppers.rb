# == Schema Information
#
# Table name: shoppers
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  current_public_api     :string           default("za-wc.public-grocery-price-book-api.co.za"), not null
#

FactoryGirl.define do
  factory :shopper do
    sequence(:email) { |n| "person#{n}@example.com" }
    password {'123123123'}
    password_confirmation {'123123123'}
    confirmed_at Time.current
  end
end
