# frozen_string_literal: true
# == Schema Information
#
# Table name: shopping_lists
#
#  old_id            :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  title             :string
#  old_price_book_id :integer
#  price_book_id     :uuid
#  id                :uuid             not null, primary key
#

FactoryGirl.define do
  factory :shopping_list do
    title { "Test #{Time.current.to_i}" }
    book { PriceBook.create! }
  end
end
