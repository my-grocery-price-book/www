class AddRegionToStores < ActiveRecord::Migration
  def change
    add_column :stores, :region_code, :string, null: false, index: true
  end
end
