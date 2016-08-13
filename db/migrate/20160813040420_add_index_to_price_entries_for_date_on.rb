class AddIndexToPriceEntriesForDateOn < ActiveRecord::Migration[5.0]
  def change
    add_index :price_entries, :date_on
  end
end
