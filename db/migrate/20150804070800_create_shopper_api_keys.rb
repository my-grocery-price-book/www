class CreateShopperApiKeys < ActiveRecord::Migration
  def change
    create_table 'shopper_api_keys' do |t|
      t.integer 'shopper_id', null: false
      t.string 'api_key', null: false
      t.string 'api_url', null: false
      t.timestamps null: false
    end
  end
end
