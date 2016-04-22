class CreatePriceEntries < ActiveRecord::Migration
  def change
    create_table :price_entries do |t|
      t.date :date_on, null: false
      t.belongs_to :store, index: true, foreign_key: true
      t.string  :product_name, null: false
      t.integer :amount, null: false
      t.integer :package_size, null: false
      t.string  :package_unit, null: false
      t.integer :price_per_package_in_cents, null: false

      t.timestamps null: false
    end
  end
end
