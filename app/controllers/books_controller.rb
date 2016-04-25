class BooksController < ApplicationController
  before_action :authenticate_shopper!

  def edit
    @book = PriceBook.find(params[:id])
  end

  def update
    @book = PriceBook.find(params[:id])
    if @book.update(book_params)
      redirect_to (session[:book_update_return] || price_book_pages_path), notice: 'Update successful'
      session[:book_update_return] = nil
    else
      render :edit
    end
  end

  private

  # Only allow a trusted parameter "white item" through.
  def book_params
    params.require(:price_book).permit(:name, region_codes: [])
  end
end
