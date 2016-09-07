class ChangePriceBookPagesToUuid < ActiveRecord::Migration[5.0]
  def up
    add_column :price_book_pages, :uuid, :uuid, default: "uuid_generate_v4()", null: false

    execute "ALTER TABLE price_book_pages DROP CONSTRAINT price_book_pages_pkey;"
    change_column :price_book_pages, :id, :integer, null: true
    change_table :price_book_pages do |t|
      t.rename :id, :old_id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE price_book_pages ADD PRIMARY KEY (id);"
  end

  def down
    execute "ALTER TABLE price_book_pages DROP CONSTRAINT price_book_pages_pkey;"
    change_table :price_book_pages do |t|
      t.rename :id, :uuid
      t.rename :old_id, :id
    end
    execute "ALTER TABLE price_book_pages ADD PRIMARY KEY (id);"

    remove_column :price_book_pages, :uuid
  end
end
