class SignedInShoppingListDetails
  attr_reader :shopper
  attr_reader :price_book
  attr_reader :shopping_list

  def initialize
    @shopper = FactoryGirl.create(:shopper)
    @price_book = PriceBook.create!(shopper: shopper)
    @shopping_list = FactoryGirl.create(:shopping_list, book: price_book)
  end
end

class ShoppingListItemsControllerTest < ActionController::TestCase
  tests ShoppingListItemsController

  def signed_in_details
    @signed_in_details ||= SignedInShoppingListDetails.new
  end

  def shopper
    signed_in_details.shopper
  end

  def price_book
    signed_in_details.price_book
  end

  def shopping_list
    signed_in_details.shopping_list
  end

  def create_shopping_list_and_sign_in
    sign_in signed_in_details.shopper, scope: :shopper
  end
end
