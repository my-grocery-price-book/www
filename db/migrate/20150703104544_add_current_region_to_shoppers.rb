class AddCurrentRegionToShoppers < ActiveRecord::Migration
  def change
    change_table 'shoppers' do |t|
      t.string :current_public_api,
               default: 'za-wc.public-grocery-price-book-api.co.za',
               null: false
    end
  end
end
