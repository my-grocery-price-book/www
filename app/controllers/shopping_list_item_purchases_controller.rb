# frozen_string_literal: true
class ShoppingListItemPurchasesController < ApplicationController
  before_action :authenticate_shopper!

  def create
    @shopping_list_item = shopping_list.purchase_item!(params[:item_id])
    respond_to do |format|
      format.html do
        redirect_to shopping_list_items_path(shopping_list)
      end
      format.json
    end
  end

  def destroy
    @shopping_list_item = shopping_list.unpurchase_item!(params[:item_id])
    respond_to do |format|
      format.html do
        redirect_to shopping_list_items_path(shopping_list)
      end
      format.json
    end
  end

  private

  def shopping_list
    @shopping_list ||= ShoppingList.for_shopper(current_shopper).find(params[:shopping_list_id])
  end
end
