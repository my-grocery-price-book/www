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
    name  { "Random #{rand(11_111)}" }
    location { "Random #{rand(11_111)}" }
    region_code { RegionFinder.instance.to_a.sample.code }
  end
end
