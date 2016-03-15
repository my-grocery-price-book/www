class CreateShoppingListItemPurchases < ActiveRecord::Migration
  def change
    create_table :shopping_list_item_purchases do |t|
      t.belongs_to :shopping_list_item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
