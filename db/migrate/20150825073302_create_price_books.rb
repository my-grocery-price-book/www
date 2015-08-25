class CreatePriceBooks < ActiveRecord::Migration
  def change
    create_table :price_books do |t|
      t.belongs_to :shopper, index: true, foreign_key: true

      t.timestamps null: false
    end

    change_table :price_book_pages do |t|
      t.belongs_to :price_book, index: true, foreign_key: true
      t.remove :shopper_id
    end
  end
end
