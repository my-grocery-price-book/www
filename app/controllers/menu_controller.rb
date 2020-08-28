# frozen_string_literal: true

class MenuController < ApplicationController
  before_action :authenticate_shopper

  # GET /price_book_pages
  def price_book_pages
    redirect_to book_pages_path(PriceBook.default_for_shopper(current_shopper))
  end
end
