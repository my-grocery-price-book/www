class ChangePriceEntriesToUuid < ActiveRecord::Migration[5.0]
  def up
    add_column :price_entries, :uuid, :uuid, default: "uuid_generate_v4()", null: false

    execute "ALTER TABLE price_entries DROP CONSTRAINT price_entries_pkey CASCADE;"
    change_column :price_entries, :id, :integer, null: true
    change_table :price_entries do |t|
      t.rename :id, :old_id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE price_entries ADD PRIMARY KEY (id);"

    up_dependent_table(:entry_owners)
  end

  def up_dependent_table(table_name)
    add_column table_name, :price_entry_uuid, :uuid
    add_index table_name, :price_entry_uuid

    change_table table_name do |t|
      t.rename :price_entry_id, :old_price_entry_id
      t.rename :price_entry_uuid, :price_entry_id
    end
  end

  def down_dependent_table(table_name)
    change_table table_name do |t|
      t.rename :price_entry_id, :price_entry_uuid
      t.rename :old_price_entry_id, :price_entry_id
    end

    remove_column table_name, :price_entry_uuid
  end

  def down
    down_dependent_table(:entry_owners)

    execute "ALTER TABLE price_entries DROP CONSTRAINT price_entries_pkey CASCADE;"
    change_table :price_entries do |t|
      t.rename :id, :uuid
      t.rename :old_id, :id
    end
    execute "ALTER TABLE price_entries ADD PRIMARY KEY (id);"

    remove_column :price_entries, :uuid
  end
end
