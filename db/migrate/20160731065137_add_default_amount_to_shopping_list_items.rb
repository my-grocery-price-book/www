class AddDefaultAmountToShoppingListItems < ActiveRecord::Migration
  def change
    change_column :shopping_list_items, :amount, :integer, default: 1, null: false
  end
end
