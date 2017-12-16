# frozen_string_literal: true

FactoryGirl.define do
  factory :page, class: PriceBook::Page do
    name 'Flour'
    category 'Food Cupboard'
    unit 'grams'
  end
end
