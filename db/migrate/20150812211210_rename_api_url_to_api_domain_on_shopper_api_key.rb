class RenameApiUrlToApiDomainOnShopperApiKey < ActiveRecord::Migration
  def change
    rename_column 'shopper_api_keys', 'api_url', 'api_root'
  end
end
