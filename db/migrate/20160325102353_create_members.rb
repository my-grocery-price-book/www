class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.belongs_to :price_book, index: true, foreign_key: true
      t.belongs_to :shopper, index: true, foreign_key: true
      t.boolean :admin, null: false, default: false

      t.timestamps null: false
    end
  end
end
