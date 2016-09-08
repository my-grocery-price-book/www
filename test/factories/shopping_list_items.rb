# frozen_string_literal: true
# == Schema Information
#
# Table name: shopping_list_items
#
#  old_id               :integer
#  old_shopping_list_id :integer
#  name                 :string
#  amount               :integer          default(1), not null
#  unit                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  id                   :uuid             not null, primary key
#  shopping_list_id     :uuid
#

FactoryGirl.define do
  factory :item, class: ShoppingList::Item do
    name { "Name #{Time.current.to_i}" }
    shopping_list
  end
end
