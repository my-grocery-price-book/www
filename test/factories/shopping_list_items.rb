# == Schema Information
#
# Table name: shopping_list_items
#
#  id               :integer          not null, primary key
#  shopping_list_id :integer
#  name             :string
#  amount           :integer
#  unit             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :shopping_list_item, class: 'ShoppingList::Item' do
    name 'MyString'
    amount 1
    unit 'MyString'
  end
end
