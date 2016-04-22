class DropShopperApiKeys < ActiveRecord::Migration
  def change
    drop_table :shopper_api_keys
  end
end
