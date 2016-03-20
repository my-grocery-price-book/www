class ShoppingListItemPurchasesController < ApplicationController
  before_action :authenticate_shopper!

  def create
    shopping_list_item.create_purchase
    respond_to do |format|
      format.html do
        shopping_list_id = shopping_list_item.shopping_list_id
        redirect_to shopping_list_items_path(shopping_list_id: shopping_list_id)
      end
      format.json
    end
  end

  def destroy
    shopping_list_item.destroy_purchase
    respond_to do |format|
      format.html do
        shopping_list_id = shopping_list_item.shopping_list_id
        redirect_to shopping_list_items_path(shopping_list_id: shopping_list_id)
      end
      format.json
    end
  end

  private

  def shopping_list_item
    @shopping_list_item ||= ShoppingList.items_for_shopper(current_shopper).find(params[:shopping_list_item_id])
  end
end
