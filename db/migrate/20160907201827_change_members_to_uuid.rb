class ChangeMembersToUuid < ActiveRecord::Migration[5.0]
  def up
    add_column :members, :uuid, :uuid, default: "uuid_generate_v1mc()", null: false

    execute "ALTER TABLE members DROP CONSTRAINT members_pkey;"
    change_column :members, :id, :integer, null: true
    change_table :members do |t|
      t.rename :id, :old_id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE members ADD PRIMARY KEY (id);"
  end

  def down
    execute "ALTER TABLE members DROP CONSTRAINT members_pkey;"
    change_table :members do |t|
      t.rename :id, :uuid
      t.rename :old_id, :id
    end
    execute "ALTER TABLE members ADD PRIMARY KEY (id);"

    remove_column :members, :uuid
  end
end
