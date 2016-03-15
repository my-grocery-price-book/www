class ShoppingListItemPurchasesController < ApplicationController
  before_action :authenticate_shopper!

  def create
    @shopping_list_item_purchase = ShoppingList::ItemPurchase.create(shopping_list_item_id: params[:shopping_list_item_id])
  end
end
