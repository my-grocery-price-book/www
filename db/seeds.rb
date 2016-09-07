# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

if Shopper.count.zero?
  Shopper.create!(email: 'test@mail.com',
                  password: 'password',
                  password_confirmation: 'password',
                  confirmed_at: Time.current)
end

PriceBook.where(_deprecated_shopper_id_migrated: false).each do |book|
  shopper = Shopper.find_by(id: book._deprecated_shopper_id)
  Rails.logger.warn "migrating #{book} to members for #{shopper}"
  book.members.create!(shopper: shopper, admin: true) if shopper
  book.update!(_deprecated_shopper_id_migrated: true)
end

ShoppingList.where(_deprecated_shopper_id_migrated: false).each do |list|
  shopper = Shopper.find_by(id: list._deprecated_shopper_id)
  Rails.logger.warn "migrating #{list} to members for #{shopper}"
  if shopper
    list.update!(_deprecated_shopper_id_migrated: true,
                 price_book_id: PriceBook.default_for_shopper(shopper).id)
  else
    list.update!(_deprecated_shopper_id_migrated: true)
  end
end

ShoppingList::ItemPurchase.where(shopping_list_item_id: nil).each do |item_purchase|
  item = ShoppingList::Item.find_by!(old_id: item_purchase.old_shopping_list_item_id)
  item_purchase.update_column(:shopping_list_item_id, item.id)
end

Member.where(price_book_id: nil).each do |member|
  book = PriceBook.find_by!(old_id: member.old_price_book_id)
  member.update_column(:price_book_id, book.id)
end

ShoppingList.where(price_book_id: nil).each do |list|
  book = PriceBook.find_by!(old_id: list.old_price_book_id)
  list.update_column(:price_book_id, book.id)
end

PriceBook::Page.where(price_book_id: nil).each do |page|
  book = PriceBook.find_by!(old_id: page.old_price_book_id)
  page.update_column(:price_book_id, book.id)
end

EntryOwner.where(price_entry_id: nil).each do |entry_owner|
  entry = PriceEntry.find_by!(old_id: entry_owner.old_price_entry_id)
  entry_owner.update_column(:price_entry_id, entry.id)
end
