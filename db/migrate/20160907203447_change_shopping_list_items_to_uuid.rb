class ChangeShoppingListItemsToUuid < ActiveRecord::Migration[5.0]
  def up
    add_column :shopping_list_items, :uuid, :uuid, default: "uuid_generate_v4()", null: false

    execute "ALTER TABLE shopping_list_items DROP CONSTRAINT shopping_list_items_pkey CASCADE;"
    change_column :shopping_list_items, :id, :integer, null: true
    change_table :shopping_list_items do |t|
      t.rename :id, :old_id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE shopping_list_items ADD PRIMARY KEY (id);"

    add_column :shopping_list_item_purchases, :shopping_list_item_uuid, :uuid
    add_index :shopping_list_item_purchases, :shopping_list_item_uuid

    change_table :shopping_list_item_purchases do |t|
      t.rename :shopping_list_item_id, :old_shopping_list_item_id
      t.rename :shopping_list_item_uuid, :shopping_list_item_id
    end
  end

  def down
    change_table :shopping_list_item_purchases do |t|
      t.rename :shopping_list_item_id, :shopping_list_item_uuid
      t.rename :old_shopping_list_item_id, :shopping_list_item_id
    end

    remove_column :shopping_list_item_purchases, :shopping_list_item_uuid

    execute "ALTER TABLE shopping_list_items DROP CONSTRAINT shopping_list_items_pkey CASCADE;"
    change_table :shopping_list_items do |t|
      t.rename :id, :uuid
      t.rename :old_id, :id
    end
    execute "ALTER TABLE shopping_list_items ADD PRIMARY KEY (id);"

    remove_column :shopping_list_items, :uuid
  end
end
