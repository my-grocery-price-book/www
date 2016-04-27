# == Schema Information
#
# Table name: price_entries
#
#  id                   :integer          not null, primary key
#  date_on              :date             not null
#  store_id             :integer
#  product_name         :string           not null
#  amount               :integer          not null
#  package_size         :integer          not null
#  package_unit         :string           not null
#  total_price_in_cents :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class EntriesController < ApplicationController
  before_action :check_if_region_set, only: [:new]
  before_action :load_page

  def new
    @entry = PriceEntry.new(date_on: Date.current, amount: 1)
    session[:book_store_create_return] = new_book_page_entry_path
  end

  def create
    @entry = PriceEntry.new(entry_params)
    @entry.package_unit = @page.unit
    if @entry.save
      current_shopper.create_entry_owner!(@entry)
      @page.add_product_name!(@entry.product_name)
      redirect_to book_page_path(book, @page)
    else
      render 'new'
    end
  end

  private

  # Only allow a trusted parameter "white item" through.
  def entry_params
    params.require(:price_entry).permit(
      :date_on, :store_id, :product_name, :amount, :package_size, :total_price
    )
  end

  def book
    @book ||= PriceBook.find_for_shopper(current_shopper, params[:book_id])
  end

  def load_page
    @page = book.find_page!(params[:page_id])
  end

  def check_if_region_set
    if book.region_set?
      true
    else
      session[:book_update_return] = new_book_page_entry_path
      redirect_to edit_book_path(book), alert: 'book requires region first'
      false
    end
  end
end
