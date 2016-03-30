require 'test_helper'

class ShopperMailerTest < ActionMailer::TestCase
  test 'invite' do
    invite = Invite.create!(name: 'Gman', email: 'to@example.org', price_book: PriceBook.create!)
    mail = ShopperMailer.invite(invite)
    assert_equal 'Invite to My Grocery Price Book', mail.subject
    assert_equal ['to@example.org'], mail.to
    assert_equal ['no-reply@my-grocery-price-book.co.za'], mail.from
    assert_match 'Dear Gman', mail.body.encoded
  end
end
