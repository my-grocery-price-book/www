class ChangeQuantityColumnTypeOnPurchaseItems < ActiveRecord::Migration
  def change
    change_column 'purchase_items', 'quantity', 'integer'
  end
end
