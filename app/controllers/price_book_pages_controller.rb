class PriceBookPagesController < ApplicationController
  before_action :authenticate_shopper!
  before_action :set_price_book_page, only: [:show, :edit, :update, :destroy, :delete]

  # GET /price_book_pages
  def index
    @price_book_pages = PriceBookPage.for_shopper(current_shopper)
    @price_book_pages = @price_book_pages.where('name ILIKE ?', "%#{params[:term]}%")
  end

  # GET /price_book_pages/1
  def show
  end

  # GET /price_book_pages/new
  def new
    @price_book_page = PriceBookPage.new
  end

  # GET /price_book_pages/1/delete
  def delete
  end

  # GET /price_book_pages/1/edit
  def edit
  end

  # POST /price_book_pages
  def create
    @price_book_page = PriceBookPage.new(price_book_page_params)
    @price_book_page.shopper = current_shopper

    if @price_book_page.save
      redirect_to price_book_pages_path, notice: 'Page was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /price_book_pages/1
  def update
    if @price_book_page.update(price_book_page_params)
      redirect_to @price_book_page, notice: 'Page was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /price_book_pages/1
  def destroy
    @price_book_page.destroy
    redirect_to price_book_pages_url, notice: 'Page was successfully deleted.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_price_book_page
    @price_book_page = PriceBookPage.find(params[:id])
  end

  # Only allow a trusted parameter "white item" through.
  def price_book_page_params
    params.require(:price_book_page).permit(:name, :category, :unit)
  end
end
