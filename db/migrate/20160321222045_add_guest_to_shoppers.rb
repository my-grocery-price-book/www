class AddGuestToShoppers < ActiveRecord::Migration
  def change
    add_column :shoppers, :guest, :boolean, default: false, null: false
  end
end
