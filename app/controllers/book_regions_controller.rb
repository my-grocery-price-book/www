class BookRegionsController < ApplicationController
  before_action :authenticate_shopper!

  def select_country
    book
  end

  def new
    @regions = RegionFinder.instance.for_alpha_3_code(params[:country_code])
    if @regions.empty?
      Rollbar.warn("No Regions Found in #{params[:country_code]}")
      redirect_to(select_country_book_regions_path, alert: 'no regions found')
    else
      book
    end
  end

  def create
    book.update!(book_params)
    redirect_to (session[:book_regions_create_return] || book_pages_path), notice: 'Update successful'
    session[:book_regions_create_return] = nil
  end

  private

  # Only allow a trusted parameter "white item" through.
  def book_params
    params.require(:price_book).permit(region_codes: [])
  end

  def book
    @book ||= PriceBook.find_for_shopper(current_shopper, params[:book_id])
  end
end
