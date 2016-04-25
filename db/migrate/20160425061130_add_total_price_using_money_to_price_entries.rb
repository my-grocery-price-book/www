class AddTotalPriceUsingMoneyToPriceEntries < ActiveRecord::Migration
  def change
    add_column :price_entries, :total_price, :money, null: false
    remove_column :price_entries, :total_price_in_cents, :integer
  end
end
