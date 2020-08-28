# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :authenticate_shopper

  def edit
    book
  end

  def update
    if book.update(book_params)
      redirect_to (session[:book_update_return] || book_pages_path(book)), notice: 'Update successful'
      session[:book_update_return] = nil
    else
      render :edit
    end
  end

  private

  # Only allow a trusted parameter "white item" through.
  def book_params
    params.require(:price_book).permit(:name)
  end

  def book
    @book ||= PriceBook.find_for_shopper(current_shopper, params[:id])
  end
end
