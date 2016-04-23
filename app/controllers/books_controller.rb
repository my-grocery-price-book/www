class BooksController < ApplicationController
  before_action :authenticate_shopper!

  def edit
    @book = PriceBook.find(params[:id])
  end

  def update
    @book = PriceBook.find(params[:id])
    if @book.update(book_params)
      redirect_to price_book_pages_path, notice: 'Update successful'
    else
      render :edit
    end
  end

  private

  # Only allow a trusted parameter "white item" through.
  def book_params
    params.require(:price_book).permit(:name)
  end
end
