class ChangeShoppingListsToUuid < ActiveRecord::Migration[5.0]
  def up
    add_column :shopping_lists, :uuid, :uuid, default: "uuid_generate_v4()", null: false

    execute "ALTER TABLE shopping_lists DROP CONSTRAINT shopping_lists_pkey CASCADE;"
    change_column :shopping_lists, :id, :integer, null: true
    change_table :shopping_lists do |t|
      t.rename :id, :old_id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE shopping_lists ADD PRIMARY KEY (id);"

    up_dependent_table(:shopping_list_items)
  end

  def up_dependent_table(table_name)
    add_column table_name, :shopping_list_uuid, :uuid
    add_index table_name, :shopping_list_uuid

    change_table table_name do |t|
      t.rename :shopping_list_id, :old_shopping_list_id
      t.rename :shopping_list_uuid, :shopping_list_id
    end
  end

  def down_dependent_table(table_name)
    change_table table_name do |t|
      t.rename :shopping_list_id, :shopping_list_uuid
      t.rename :old_shopping_list_id, :shopping_list_id
    end

    remove_column table_name, :shopping_list_uuid
  end

  def down
    down_dependent_table(:shopping_list_items)

    execute "ALTER TABLE shopping_lists DROP CONSTRAINT shopping_lists_pkey CASCADE;"
    change_table :shopping_lists do |t|
      t.rename :id, :uuid
      t.rename :old_id, :id
    end
    execute "ALTER TABLE shopping_lists ADD PRIMARY KEY (id);"

    remove_column :shopping_lists, :uuid
  end
end
