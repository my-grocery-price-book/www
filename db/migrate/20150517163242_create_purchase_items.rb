class CreatePurchaseItems < ActiveRecord::Migration
  def change
    create_table :purchase_items do |t|
      t.belongs_to :purchase, index: true, foreign_key: true
      t.string :product_brand_name
      t.string :generic_name
      t.string :package_type
      t.decimal :package_size
      t.string :package_unit
      t.decimal :quanity
      t.decimal :total_price

      t.timestamps null: false
    end
  end
end
