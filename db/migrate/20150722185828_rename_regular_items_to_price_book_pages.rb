class RenamePriceBookPagesToPriceBookPages < ActiveRecord::Migration
  def change
    rename_table 'price_book_pages', 'price_book_pages'
  end
end
