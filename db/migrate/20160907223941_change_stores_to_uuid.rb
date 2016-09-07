class ChangeStoresToUuid < ActiveRecord::Migration[5.0]
  def up
    add_column :stores, :uuid, :uuid, default: "uuid_generate_v4()", null: false

    execute "ALTER TABLE stores DROP CONSTRAINT stores_pkey CASCADE;"
    change_column :stores, :id, :integer, null: true
    change_table :stores do |t|
      t.rename :id, :old_id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE stores ADD PRIMARY KEY (id);"

    add_column :price_books, :store_uuids, :uuid, array: true, default: []

    change_table :price_books do |t|
      t.rename :store_ids, :old_store_ids
      t.rename :store_uuids, :store_ids
    end

    up_dependent_table(:price_entries)
  end

  def up_dependent_table(table_name)
    add_column table_name, :store_uuid, :uuid
    add_index table_name, :store_uuid

    change_table table_name do |t|
      t.rename :store_id, :old_store_id
      t.rename :store_uuid, :store_id
    end
  end

  def down_dependent_table(table_name)
    change_table table_name do |t|
      t.rename :store_id, :store_uuid
      t.rename :old_store_id, :store_id
    end

    remove_column table_name, :store_uuid
  end

  def down
    down_dependent_table(:price_entries)

    change_table :price_books do |t|
      t.rename :store_ids, :store_uuids
      t.rename :old_store_ids, :store_ids
    end

    remove_column :price_books, :store_uuids

    execute "ALTER TABLE stores DROP CONSTRAINT stores_pkey CASCADE;"
    change_table :stores do |t|
      t.rename :id, :uuid
      t.rename :old_id, :id
    end
    execute "ALTER TABLE stores ADD PRIMARY KEY (id);"

    remove_column :stores, :uuid
  end
end
