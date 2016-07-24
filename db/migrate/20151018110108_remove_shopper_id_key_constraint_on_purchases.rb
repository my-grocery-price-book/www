class RemoveShopperIdKeyConstraintOnPurchases < ActiveRecord::Migration
  def change
    remove_foreign_key(:purchases, :shoppers)
  end
end
