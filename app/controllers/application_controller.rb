# frozen_string_literal: true
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_book

  def current_book
    PriceBook.for_shopper(current_shopper).find_by(id: params[:book_id]) ||
      PriceBook.default_for_shopper(current_shopper)
  end

  # before_action :slow_down_if_xhr

  # def slow_down_if_xhr
  #   sleep(3) if request.xhr?
  # end
end
