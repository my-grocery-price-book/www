class AddShopperIdMigratedToPriceBook < ActiveRecord::Migration
  def change
    add_column :price_books, :_deprecated_shopper_id_migrated, :boolean, default: false, null: false
  end
end
