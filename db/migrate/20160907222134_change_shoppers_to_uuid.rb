class ChangeShoppersToUuid < ActiveRecord::Migration[5.0]
  def up
    add_column :shoppers, :uuid, :uuid, default: "uuid_generate_v1mc()", null: false

    execute "ALTER TABLE shoppers DROP CONSTRAINT shoppers_pkey CASCADE;"
    change_column :shoppers, :id, :integer, null: true
    change_table :shoppers do |t|
      t.rename :id, :old_id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE shoppers ADD PRIMARY KEY (id);"

    up_dependent_table(:entry_owners)
    up_dependent_table(:members)
  end

  def up_dependent_table(table_name)
    add_column table_name, :shopper_uuid, :uuid
    add_index table_name, :shopper_uuid

    change_table table_name do |t|
      t.rename :shopper_id, :old_shopper_id
      t.rename :shopper_uuid, :shopper_id
    end
  end

  def down_dependent_table(table_name)
    change_table table_name do |t|
      t.rename :shopper_id, :shopper_uuid
      t.rename :old_shopper_id, :shopper_id
    end

    remove_column table_name, :shopper_uuid
  end

  def down
    down_dependent_table(:entry_owners)
    down_dependent_table(:members)

    execute "ALTER TABLE shoppers DROP CONSTRAINT shoppers_pkey CASCADE;"
    change_table :shoppers do |t|
      t.rename :id, :uuid
      t.rename :old_id, :id
    end
    execute "ALTER TABLE shoppers ADD PRIMARY KEY (id);"

    remove_column :shoppers, :uuid
  end
end
