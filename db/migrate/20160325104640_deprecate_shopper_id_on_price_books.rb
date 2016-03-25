class DeprecateShopperIdOnPriceBooks < ActiveRecord::Migration
  def change
    rename_column :price_books, :shopper_id, :_deprecated_shopper_id
  end
end
