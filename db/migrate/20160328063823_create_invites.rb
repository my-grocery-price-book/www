class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.belongs_to :price_book, index: true, foreign_key: true
      t.string :name
      t.string :email
      t.string :status, default: 'sent', null: false
      t.string :token, null: false, index: true

      t.timestamps null: false
    end
  end
end
