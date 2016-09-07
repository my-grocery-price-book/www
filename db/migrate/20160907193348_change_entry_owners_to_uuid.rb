class ChangeEntryOwnersToUuid < ActiveRecord::Migration[5.0]
  def up
    add_column :entry_owners, :uuid, :uuid, default: "uuid_generate_v1mc()", null: false

    execute "ALTER TABLE entry_owners DROP CONSTRAINT entry_owners_pkey;"
    change_column :entry_owners, :id, :integer, null: true
    change_table :entry_owners do |t|
      t.rename :id, :old_id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE entry_owners ADD PRIMARY KEY (id);"
  end

  def down
    execute "ALTER TABLE entry_owners DROP CONSTRAINT entry_owners_pkey;"
    change_table :entry_owners do |t|
      t.rename :id, :uuid
      t.rename :old_id, :id
    end
    execute "ALTER TABLE entry_owners ADD PRIMARY KEY (id);"

    remove_column :entry_owners, :uuid
  end
end
