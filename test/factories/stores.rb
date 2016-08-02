# == Schema Information
#
# Table name: stores
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  location    :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  region_code :string           not null
#

FactoryGirl.define do
  factory :store do
    name  'World'
    location 'Space'
    region_code 'ZAR-WC'
  end
end
