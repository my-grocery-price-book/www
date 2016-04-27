class CreateEntryOwners < ActiveRecord::Migration
  def change
    create_table :entry_owners do |t|
      t.belongs_to :price_entry, index: true, foreign_key: true
      t.belongs_to :shopper, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
