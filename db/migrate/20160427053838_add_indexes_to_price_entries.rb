class AddIndexesToPriceEntries < ActiveRecord::Migration
  def up
    execute "CREATE INDEX price_entries_replace_lower_product_name_idx ON price_entries (replace(LOWER(product_name), ' ', ''))"
    add_index :price_entries, :package_unit
  end

  def down
    remove_index :price_entries, :package_unit
    execute "DROP INDEX price_entries_replace_lower_product_name_idx"
  end
end
