class RemoveColumnsFromPurchasesItems < ActiveRecord::Migration
  def change
    remove_column :purchase_items, :generic_name, :string
    remove_column :purchase_items, :package_type, :string
  end
end
