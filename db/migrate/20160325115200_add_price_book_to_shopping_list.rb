class AddPriceBookToShoppingList < ActiveRecord::Migration
  def change
    add_reference :shopping_lists, :price_book, index: true, foreign_key: true
  end
end
