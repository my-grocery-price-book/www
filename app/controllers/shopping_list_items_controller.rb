class ShoppingListItemsController < ApplicationController
  before_action :authenticate_shopper!

  def create
    @item = shopping_list.items.create!(item_params)
    respond_to do |format|
      format.html { shopping_list_path(shopping_list) }
      format.json { render json: @item}
    end
  end

  def done
    shopping_list_item.update_attribute(:done, true)
    redirect_to shopping_list_path(shopping_list)
  end

  def destroy
    shopping_list_item.destroy
    redirect_to shopping_list_path(shopping_list)
  end

  private

  def shopping_list
    ShoppingList.for_shopper(current_shopper).find(params[:shopping_list_id])
  end

  def shopping_list_item
    shopping_list.items.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def item_params
    params.require(:shopping_list_item).permit(:name, :amount, :unit)
  end
end
