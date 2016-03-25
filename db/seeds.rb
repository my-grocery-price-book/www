# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

if Shopper.count == 0
  Shopper.create!(email: 'test@mail.com',
                  password: 'password',
                  password_confirmation: 'password',
                  confirmed_at: Time.current)
end

PriceBook.where(_deprecated_shopper_id_migrated: false).each do |book|
  shopper = Shopper.find(book._deprecated_shopper_id)
  Rails.logger.warn "migrating #{book} to members for #{shopper}"
  book.members.create!(shopper: shopper, admin: true)
  book.update!(_deprecated_shopper_id_migrated: true)
end
