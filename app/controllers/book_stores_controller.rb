class BookStoresController < ApplicationController
  before_action :check_if_region_set

  def new
    @store = Store.new
  end

  def create
    @store = Store.find_or_initialize(store_params)
    if @store.save
      @book.add_store!(@store)
      redirect_to session[:book_store_create_return] || book_pages_path
      session[:book_store_create_return] = nil
    else
      render 'new'
    end
  end

  private

  # Only allow a trusted parameter "white item" through.
  def store_params
    params.require(:store).permit(:name, :location, :region_code)
  end

  def book
    @book ||= PriceBook.find_for_shopper(current_shopper, params[:book_id])
  end

  def check_if_region_set
    if book.region_set?
      true
    else
      session[:book_update_return] = new_book_store_path
      redirect_to edit_book_path(book), alert: 'book requires region first'
      false
    end
  end
end
