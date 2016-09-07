class ChangeShoppingListItemPurchasesToUuid < ActiveRecord::Migration[5.0]
  def up
    add_column :shopping_list_item_purchases, :uuid, :uuid, default: "uuid_generate_v1mc()", null: false

    execute "ALTER TABLE shopping_list_item_purchases DROP CONSTRAINT shopping_list_item_purchases_pkey;"
    change_column :shopping_list_item_purchases, :id, :integer, null: true
    change_table :shopping_list_item_purchases do |t|
      t.rename :id, :old_id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE shopping_list_item_purchases ADD PRIMARY KEY (id);"
  end

  def down
    execute "ALTER TABLE shopping_list_item_purchases DROP CONSTRAINT shopping_list_item_purchases_pkey;"
    change_table :shopping_list_item_purchases do |t|
      t.rename :id, :uuid
      t.rename :old_id, :id
    end
    execute "ALTER TABLE shopping_list_item_purchases ADD PRIMARY KEY (id);"

    remove_column :shopping_list_item_purchases, :uuid
  end
end
