class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.date :purchased_on
      t.string :store
      t.string :location

      t.timestamps null: false
    end
  end
end
