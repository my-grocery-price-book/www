class AddUnitToPriceBookPages < ActiveRecord::Migration
  def change
    change_table 'price_book_pages' do |t|
      t.string :unit
    end
  end
end
