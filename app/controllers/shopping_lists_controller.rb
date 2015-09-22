class ShoppingListsController < ApplicationController
  before_action :authenticate_shopper!

  # GET /shopping_lists
  def index
    @shopping_lists = ShoppingList.for_shopper(current_shopper).each { |list| list.extend(ShoppingListDecorator) }
  end

  # GET /shopping_lists/1
  def show
    @shopping_list = shopping_list.extend(ShoppingListDecorator)
    @shopping_list_items = @shopping_list.items.each { |item| item.extend(ShoppingListItemDecorator) }
  end

  # POST /shopping_lists
  def create
    shopping_list = ShoppingList.create(shopper: current_shopper)
    redirect_to shopping_list, notice: 'Shopping list was successfully created.'
  end

  # DELETE /shopping_lists/1
  def destroy
    shopping_list.destroy
    redirect_to shopping_lists_url, notice: 'Shopping list was successfully destroyed.'
  end

  private

  def shopping_list
    ShoppingList.for_shopper(current_shopper).find(params[:id])
  end
  #
  # # Only allow a trusted parameter "white list" through.
  # def shopping_list_params
  #   params.require(:shopping_list).permit(:due_date)
  # end
end
