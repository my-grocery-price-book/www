class DropDoneFromShoppingListItems < ActiveRecord::Migration
  def change
    remove_column :shopping_list_items, :done, :boolean, default: false, null: false
  end
end
