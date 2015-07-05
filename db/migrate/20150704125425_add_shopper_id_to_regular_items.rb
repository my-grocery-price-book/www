class AddShopperIdToRegularItems < ActiveRecord::Migration
  def change
    change_table :regular_items do |t|
      t.belongs_to :shopper, index: true, foreign_key: true
    end
  end
end
