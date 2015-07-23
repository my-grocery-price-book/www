class RemoveForeignKeyFromPurchaseItems < ActiveRecord::Migration
  def change
    remove_foreign_key('purchase_items', 'purchase')
  end
end
