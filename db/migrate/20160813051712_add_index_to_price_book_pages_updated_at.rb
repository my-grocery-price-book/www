class AddIndexToPriceBookPagesUpdatedAt < ActiveRecord::Migration[5.0]
  def change
    add_index :price_book_pages, :updated_at
  end
end
