class RemoveShopperIdKeyConstraintOnShoppingLists < ActiveRecord::Migration
  def change
    remove_foreign_key(:shopping_lists, :shoppers)
  end
end
