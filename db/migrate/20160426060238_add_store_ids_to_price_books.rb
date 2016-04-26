class AddStoreIdsToPriceBooks < ActiveRecord::Migration
  def change
    change_table :price_books do |t|
      t.integer :store_ids, array: true, default: []
    end
  end
end
