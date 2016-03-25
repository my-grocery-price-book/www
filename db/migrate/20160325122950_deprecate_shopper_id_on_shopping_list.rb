class DeprecateShopperIdOnShoppingList < ActiveRecord::Migration
  def change
    add_column :shopping_lists, :_deprecated_shopper_id_migrated, :boolean, default: false, null: false
    rename_column :shopping_lists, :shopper_id, :_deprecated_shopper_id
  end
end
