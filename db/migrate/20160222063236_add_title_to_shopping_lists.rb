class AddTitleToShoppingLists < ActiveRecord::Migration
  def change
    add_column :shopping_lists, :title, :string
  end
end
