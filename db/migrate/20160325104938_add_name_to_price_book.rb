class AddNameToPriceBook < ActiveRecord::Migration
  def change
    add_column :price_books, :name, :string, null: false, default: 'My Price Book'
  end
end
