class AddCompletedAtToPurchases < ActiveRecord::Migration
  def change
    change_table :purchases do |t|
      t.datetime :completed_at
    end
  end
end
