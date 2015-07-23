class AddProductNamesToRegularItems < ActiveRecord::Migration
  def change
    change_table :regular_items do |t|
      t.text :product_names, array: true, default: []
    end
  end
end
