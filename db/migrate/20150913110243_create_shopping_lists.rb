class CreateShoppingLists < ActiveRecord::Migration
  def change
    create_table :shopping_lists do |t|
      t.belongs_to :shopper, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
