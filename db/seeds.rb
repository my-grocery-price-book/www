# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Shopper.create!(email: 'test@mail.com') if Shopper.count.zero?

ShoppingList::Item.where(shopping_list_id: nil).each do |item|
  list = ShoppingList.find_by!(old_id: item.old_shopping_list_id)
  item.update_column(:shopping_list_id, list.id)
end

ShoppingList::ItemPurchase.where(shopping_list_item_id: nil).each do |item_purchase|
  item = ShoppingList::Item.find_by!(old_id: item_purchase.old_shopping_list_item_id)
  item_purchase.update_column(:shopping_list_item_id, item.id)
end

Member.where(price_book_id: nil).each do |member|
  book = PriceBook.find_by!(old_id: member.old_price_book_id)
  member.update_column(:price_book_id, book.id)
end

Member.where(shopper_id: nil).each do |member|
  shopper = Shopper.find_by!(old_id: member.old_shopper_id)
  member.update_column(:shopper_id, shopper.id)
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

EntryOwner.where(shopper_id: nil).each do |entry_owner|
  shopper = Shopper.find_by!(old_id: entry_owner.old_shopper_id)
  entry_owner.update_column(:shopper_id, shopper.id)
end

PriceEntry.where(store_id: nil).each do |entry|
  store = Store.find_by!(old_id: entry.old_store_id)
  entry.update_column(:store_id, store.id)
end

PriceBook.all.each do |book|
  if book.store_ids.blank? && book.old_store_ids.present?
    stores = Store.where(old_id: book.old_store_ids)
    book.update_column(:store_ids, stores.map(&:id))
  end
end
