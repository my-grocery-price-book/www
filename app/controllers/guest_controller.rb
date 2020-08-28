# frozen_string_literal: true

class GuestController < ApplicationController
  def login
    @shopper = Shopper.create!(guest: true)
    sign_in(@shopper)
    redirect_to price_book_pages_path, notice: 'Logged in as Guest'
  end

  def register
    @shopper = current_shopper
    session[:guest_register_return] = request.referer
  end
end
