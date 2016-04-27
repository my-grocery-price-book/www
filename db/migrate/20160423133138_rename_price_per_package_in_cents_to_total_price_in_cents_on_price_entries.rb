class RenamePricePerPackageInCentsToTotalPriceInCentsOnPriceEntries < ActiveRecord::Migration
  def change
    rename_column :price_entries, :price_per_package_in_cents, :total_price_in_cents
  end
end
