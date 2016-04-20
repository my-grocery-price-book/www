class ShoppingListItemsController < ApplicationController
  before_action :authenticate_shopper!

  def names
    @book = PriceBook.find_for_shopper(current_shopper, params[:book_id])
    @names = ShoppingList.item_names_for_book(@book, query: params[:query])
  end

  def index
    shopping_list
  end

  def latest
    @shopping_list = ShoppingList.for_shopper(current_shopper).first
    render :index
  end

  def create
    @item = shopping_list.items.create!(item_params)
    respond_to do |format|
      format.html { redirect_to shopping_list_items_path(shopping_list) }
      format.json
    end
  end

  def destroy
    @shopping_list_item = ShoppingList.items_for_shopper(current_shopper).find(params[:id])
    @shopping_list_item.destroy
    respond_to do |format|
      format.html { redirect_to shopping_list_items_path(shopping_list_id: @shopping_list_item.shopping_list_id) }
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
