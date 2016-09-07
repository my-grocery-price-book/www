class DropShoppingListDeprecatedColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :shopping_lists, :_deprecated_shopper_id, :integer
    remove_column :shopping_lists, :_deprecated_shopper_id_migrated, :boolean, default: false, null: false
  end
end
