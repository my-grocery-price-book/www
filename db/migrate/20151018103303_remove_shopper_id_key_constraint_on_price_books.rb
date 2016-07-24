class RemoveShopperIdKeyConstraintOnPriceBooks < ActiveRecord::Migration
  def change
    remove_foreign_key(:price_books, :shoppers)
  end
end
