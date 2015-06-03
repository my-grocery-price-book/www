class AddCategoryToPurchaseItems < ActiveRecord::Migration
  def change
    change_table :purchase_items do |t|
      t.string :category, index: true
    end
  end
end
