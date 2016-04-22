class DropCurrentPublicApiFromShoppers < ActiveRecord::Migration
  def change
    remove_column :shoppers, :current_public_api, :string
  end
end
