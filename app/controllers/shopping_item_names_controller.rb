# frozen_string_literal: true

class ShoppingItemNamesController < ApplicationController
  before_action :authenticate_shopper!

  def index
    @names = ShoppingList.item_names_for_book(book, query: params[:query])
  end

  private

  def book
    PriceBook.find_for_shopper(current_shopper, params[:book_id])
  end
end
