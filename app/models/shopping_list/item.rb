# == Schema Information
#
# Table name: shopping_list_items
#
#  id                :integer          not null, primary key
#  shopping_lists_id :integer
#  name              :string
#  amount            :integer
#  unit              :string
#  done              :boolean          default(FALSE), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class ShoppingList::Item < ActiveRecord::Base
end
