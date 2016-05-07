class PriceBookPagesController < ApplicationController
  before_action :authenticate_shopper!
  before_action :load_price_book
  before_action :set_price_book_page, only: [:show, :edit, :update, :destroy, :delete]

  # GET /price_book_pages
  def index
    @price_book_pages = @price_book.search_pages(params[:term])
  end

  # GET /price_book_pages/1
  def show
    @prices = @price_book_page.entries(@price_book.store_ids)
  end

  # GET /price_book_pages/new
  def new
    @price_book_page = @price_book.pages.new
  end

  # GET /price_book_pages/1/delete
  def delete
  end

  # GET /price_book_pages/1/edit
  def edit
    session[:price_book_pages_update_return] = request.referrer
  end

  # POST /price_book_pages
  def create
    @price_book_page = @price_book.pages.new(price_book_page_params)
    if @price_book_page.save
      redirect_to price_book_pages_path, notice: 'Page was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /price_book_pages/1
  def update
    if @price_book_page.update(price_book_page_params)
      redirect_to session[:price_book_pages_update_return] || price_book_pages_path,
                  notice: 'Page was successfully updated.'
      session[:price_book_pages_update_return] = nil
    else
      render :edit
    end
  end

  # DELETE /price_book_pages/1
  def destroy
    @price_book_page.destroy
    redirect_to price_book_pages_path, notice: 'Page was successfully deleted.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_price_book_page
    @price_book_page = @price_book.find_page!(params[:id])
  end

  # Only allow a trusted parameter "white item" through.
  def price_book_page_params
    params.require(:price_book_page).permit(:name, :category, :unit, product_names: [])
  end

  def load_price_book
    @price_book = if params[:book_id]
                    PriceBook.find_for_shopper(current_shopper, params[:book_id])
                  else
                    PriceBook.default_for_shopper(current_shopper)
                  end
  end
end
