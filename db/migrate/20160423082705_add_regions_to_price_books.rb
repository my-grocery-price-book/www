class AddRegionsToPriceBooks < ActiveRecord::Migration
  def change
    change_table :price_books do |t|
      t.string :region_codes, array: true, default: []
    end
  end
end
