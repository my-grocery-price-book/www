class CreateShoppingListItems < ActiveRecord::Migration
  def change
    create_table :shopping_list_items do |t|
      t.belongs_to :shopping_list
      t.string :name
      t.integer :amount
      t.string :unit
      t.boolean :done, default: false, null: false

      t.timestamps null: false
    end
  end
end
