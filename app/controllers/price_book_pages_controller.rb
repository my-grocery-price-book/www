# frozen_string_literal: true

class PriceBookPagesController < ApplicationController
  before_action :authenticate_shopper!
  before_action :load_price_book
  before_action :set_price_book_page, only: %i[show edit update destroy delete]

  # GET /books/:book_id/price_book_pages
  def index
    @price_book_pages = PriceBook::Page.for_book(@price_book)
    session[:book_entry_create_return] = book_pages_path
  end

  # GET /books/:book_id/price_book_pages/1
  def show
    @prices = @price_book_page.entries
    session[:book_entry_create_return] = book_page_path
  end

  # GET /books/:book_id/price_book_pages/new
  def new
    @price_book_page = PriceBook::Page.new
  end

  # GET /books/:book_id/price_book_pages/1/delete
  def delete; end

  # GET /books/:book_id/price_book_pages/1/edit
  def edit
    session[:price_book_pages_update_return] = request.referer
  end

  # POST /books/:book_id/price_book_pages
  def create
    @price_book_page = PriceBook::Page.new(price_book_page_params)
    @price_book_page.book = @price_book
    if @price_book_page.save
      redirect_to book_pages_path, notice: 'Page was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /books/:book_id/price_book_pages/1
  def update
    if @price_book_page.update(price_book_page_params)
      redirect_to session[:price_book_pages_update_return] || book_pages_path,
                  notice: 'Page was successfully updated.'
      session[:price_book_pages_update_return] = nil
    else
      render :edit
    end
  end

  # DELETE /books/:book_id/price_book_pages/1
  def destroy
    @price_book_page.destroy
    redirect_to book_pages_path, notice: 'Page was successfully deleted.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_price_book_page
    @price_book_page = PriceBook::Page.find_page!(@price_book, params[:id])
  end

  # Only allow a trusted parameter "white item" through.
  def price_book_page_params
    params.require(:price_book_page).permit(:name, :category, :unit, product_names: [])
  end

  def load_price_book
    @price_book = PriceBook.find_for_shopper(current_shopper, params[:book_id])
  end
end
