class RenameQuanityToQuantityOnPurchaseItems < ActiveRecord::Migration
  def change
    change_table 'purchase_items' do |t|
      t.rename 'quanity', 'quantity'
    end
  end
end
