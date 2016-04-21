class AddIndexOnCreatedAtForShoppingListItems < ActiveRecord::Migration
  def change
    add_index :shopping_list_items, :created_at
  end
end
