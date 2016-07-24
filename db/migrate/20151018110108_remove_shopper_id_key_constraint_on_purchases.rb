class RemoveShopperIdKeyConstraintOnPurchases < ActiveRecord::Migration
  def change
    remove_foreign_key(:purchases, :shopper)
  end
end
