class AddRegularNameToPurchaseItems < ActiveRecord::Migration
  def change
    change_table :purchase_items do |t|
      t.string :regular_name
    end
  end
end
