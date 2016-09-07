class ChangeInvitesToUuid < ActiveRecord::Migration[5.0]
  def up
    add_column :invites, :uuid, :uuid, default: "uuid_generate_v1mc()", null: false

    execute "ALTER TABLE invites DROP CONSTRAINT invites_pkey;"
    change_column :invites, :id, :integer, null: true
    change_table :invites do |t|
      t.rename :id, :old_id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE invites ADD PRIMARY KEY (id);"
  end

  def down
    execute "ALTER TABLE invites DROP CONSTRAINT invites_pkey;"
    change_table :invites do |t|
      t.rename :id, :uuid
      t.rename :old_id, :id
    end
    execute "ALTER TABLE invites ADD PRIMARY KEY (id);"

    remove_column :invites, :uuid
  end
end
