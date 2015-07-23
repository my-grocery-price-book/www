class CreateRegularLists < ActiveRecord::Migration
  def change
    create_table :regular_lists do |t|
      t.string :name
      t.string :category

      t.timestamps null: false
    end
  end
end
