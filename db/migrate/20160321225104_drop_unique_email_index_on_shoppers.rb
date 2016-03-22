class DropUniqueEmailIndexOnShoppers < ActiveRecord::Migration
  def change
    remove_index :shoppers, :email
    add_index :shoppers, :email
  end
end
