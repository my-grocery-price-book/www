# frozen_string_literal: true

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
  before_action :authenticate_shopper
  before_action :check_if_region_set, only: [:new]
  before_action :load_page

  def new
    @entry = EntryOwner.new_entry_for_shopper(current_shopper)
    session[:book_store_create_return] = new_book_page_entry_path
  end

  def create
    @entry = PriceEntry.new(entry_params)
    @entry.package_unit = @page.unit
    if @entry.save
      EntryOwner.create_for!(shopper: current_shopper, entry: @entry)
      @page.new_entry_added(@entry)
      return_for_book_entry_create
    else
      render 'new'
    end
  end

  private

  def return_for_book_entry_create
    redirect_to session[:book_entry_create_return] || book_page_path(book, @page)
    session[:book_entry_create_return] = nil
  end

  public

  def edit
    @entry = EntryOwner.find_entry_for_shopper(current_shopper, id: params[:id])
    session[:book_store_create_return] = edit_book_page_entry_path(book, @page, @entry)
  end

  def update
    @entry = EntryOwner.find_entry_for_shopper(current_shopper, id: params[:id])
    if @page.update_entry(@entry, entry_params)
      redirect_to book_page_path(book, @page)
    else
      book
      render :edit
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
    @page = PriceBook::Page.find_page!(book, params[:page_id])
  end

  def check_if_region_set
    if book.region_set?
      true
    else
      session[:book_regions_create_return] = new_book_page_entry_path
      redirect_to select_country_book_regions_path(book), alert: 'book requires region first'
      false
    end
  end
end
