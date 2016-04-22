class DropPurchasesAndItems < ActiveRecord::Migration
  def change
    drop_table :purchases
    drop_table :purchase_items
  end
end