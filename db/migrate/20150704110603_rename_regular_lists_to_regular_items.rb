class RenameRegularListsToRegularItems < ActiveRecord::Migration
 def self.up
    rename_table :regular_lists, :regular_items
  end

  def self.down
    rename_table :regular_items, :regular_lists
  end
end
