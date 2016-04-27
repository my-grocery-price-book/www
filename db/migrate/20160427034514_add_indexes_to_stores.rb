class AddIndexesToStores < ActiveRecord::Migration
  def up
    add_index :stores, :region_code
    execute "CREATE INDEX stores_replace_lower_name_idx ON stores (replace(LOWER(name), ' ', ''))"
    execute "CREATE INDEX stores_replace_lower_loc_idx ON stores (replace(LOWER(location), ' ', ''))"
  end

  def down
    remove_index :stores, :region_code
    execute "DROP INDEX stores_replace_lower_name_idx"
    execute "DROP INDEX stores_replace_lower_loc_idx"
  end
end
