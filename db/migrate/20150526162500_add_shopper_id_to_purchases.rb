class AddShopperIdToPurchases < ActiveRecord::Migration
  def change
    change_table :purchases do |t|
      t.belongs_to :shopper, index: true, foreign_key: true
    end
  end
end
