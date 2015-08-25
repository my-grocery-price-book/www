class PriceBookPagesController < ApplicationController
  before_action :authenticate_shopper!
  before_action :load_price_book
  before_action :set_price_book_page, only: [:show, :edit, :delete]

  # GET /price_book_pages
  def index
    @price_book_pages = @price_book.search_pages(params[:term])
  end

  # GET /price_book_pages/1
  def show
  end

  # GET /price_book_pages/new
  def new
    @price_book_page = @price_book.new_page
  end

  # GET /price_book_pages/1/delete
  def delete
  end

  # GET /price_book_pages/1/edit
  def edit
  end

  # POST /price_book_pages
  def create
    @price_book.add_page!(price_book_page_params)
    redirect_to price_book_pages_path, notice: 'Page was successfully created.'
  end

  # PATCH/PUT /price_book_pages/1
  def update
    @price_book.update_page!(params[:id],price_book_page_params)
    redirect_to price_book_pages_path, notice: 'Page was successfully updated.'
  end

  # DELETE /price_book_pages/1
  def destroy
    @price_book.destroy_page(params[:id])
    redirect_to price_book_pages_path, notice: 'Page was successfully deleted.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_price_book_page
    @price_book_page = @price_book.find_page!(params[:id])
  end

  # Only allow a trusted parameter "white item" through.
  def price_book_page_params
    params.require(:price_book_page).permit(:name, :category, :unit)
  end

  def load_price_book
    @price_book = PriceBook.for_shopper(current_shopper)
  end
end
