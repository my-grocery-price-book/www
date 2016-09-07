# == Schema Information
#
# Table name: shopping_lists
#
#  id                              :integer          not null, primary key
#  _deprecated_shopper_id          :integer
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  title                           :string
#  old_price_book_id               :integer
#  _deprecated_shopper_id_migrated :boolean          default(FALSE), not null
#  price_book_id                   :uuid
#

FactoryGirl.define do
  factory :shopping_list do
    title { "Test #{Time.current.to_i}" }
    book { PriceBook.create! }
  end
end
