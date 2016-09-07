class ChangePriceBooksToUuid < ActiveRecord::Migration[5.0]
  def up
    add_column :price_books, :uuid, :uuid, default: "uuid_generate_v4()", null: false

    execute "ALTER TABLE price_books DROP CONSTRAINT price_books_pkey CASCADE;"
    change_column :price_books, :id, :integer, null: true
    change_table :price_books do |t|
      t.rename :id, :old_id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE price_books ADD PRIMARY KEY (id);"

    up_dependent_table(:invites)
    up_dependent_table(:members)
    up_dependent_table(:shopping_lists)
    up_dependent_table(:price_book_pages)
  end

  def up_dependent_table(table_name)
    add_column table_name, :price_book_uuid, :uuid
    add_index table_name, :price_book_uuid

    change_table table_name do |t|
      t.rename :price_book_id, :old_price_book_id
      t.rename :price_book_uuid, :price_book_id
    end
  end

  def down_dependent_table(table_name)
    change_table table_name do |t|
      t.rename :price_book_id, :price_book_uuid
      t.rename :old_price_book_id, :price_book_id
    end

    remove_column table_name, :price_book_uuid
  end

  def down
    down_dependent_table(:invites)
    down_dependent_table(:members)
    down_dependent_table(:shopping_lists)
    down_dependent_table(:price_book_pages)

    execute "ALTER TABLE price_books DROP CONSTRAINT price_books_pkey CASCADE;"
    change_table :price_books do |t|
      t.rename :id, :uuid
      t.rename :old_id, :id
    end
    execute "ALTER TABLE price_books ADD PRIMARY KEY (id);"

    remove_column :price_books, :uuid
  end
end
