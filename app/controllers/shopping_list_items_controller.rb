# frozen_string_literal: true

class ShoppingListItemsController < ApplicationController
  before_action :authenticate_shopper

  def index
    @pages = PriceBook::Page.for_book(shopping_list.book)
    fresh_when last_modified: shopping_list.updated_at.utc,
               etag: [shopping_list, request.format]
  end

  def latest
    @shopping_list = ShoppingList.first_for_shopper(current_shopper)
    if @shopping_list
      @pages = PriceBook::Page.for_book(@shopping_list.book)
      render :index
    else
      redirect_to shopping_lists_path
    end
  end

  def create
    @shopping_list_item = shopping_list.create_item(item_params)
    respond_to do |format|
      format.html { redirect_to shopping_list_items_path(shopping_list) }
      format.json
    end
  end

  def update
    @shopping_list_item = shopping_list.update_item(params[:id], item_params)
    respond_to do |format|
      format.html { redirect_to shopping_list_items_path(shopping_list) }
      format.json
    end
  end

  def destroy
    @shopping_list_item = shopping_list.destroy_item(params[:id])
    respond_to do |format|
      format.html { redirect_to shopping_list_items_path(shopping_list) }
      format.json
    end
  end

  private

  def shopping_list
    @shopping_list ||= ShoppingList.for_shopper(current_shopper).find(params[:shopping_list_id])
  end

  # Only allow a trusted parameter "white list" through.
  def item_params
    params.require(:shopping_list_item).permit(:name, :amount, :unit)
  end
end
