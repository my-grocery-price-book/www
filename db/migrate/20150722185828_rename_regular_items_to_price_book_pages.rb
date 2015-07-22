class RenameRegularItemsToPriceBookPages < ActiveRecord::Migration
  def change
    rename_table 'regular_items', 'price_book_pages'
  end
end
