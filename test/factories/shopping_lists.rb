# == Schema Information
#
# Table name: shopping_lists
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  title             :string
#  old_price_book_id :integer
#  price_book_id     :uuid
#

FactoryGirl.define do
  factory :shopping_list do
    title { "Test #{Time.current.to_i}" }
    book { PriceBook.create! }
  end
end
