class DropPriceBooksDeprecatedColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :price_books, :_deprecated_shopper_id, :integer
    remove_column :price_books, :_deprecated_shopper_id_migrated, :boolean, default: false, null: false
  end
end
