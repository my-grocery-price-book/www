class ShoppingListsController < ApplicationController
  before_action :authenticate_shopper!

  # GET /shopping_lists
  def index
    @shopping_lists = ShoppingList.for_shopper(current_shopper)
  end

  def update
    shopping_list

    if shopping_list.update(shopping_list_params)
      respond_to do |format|
        format.html { redirect_to shopping_lists_path, notice: 'Successfully updated.' }
        format.json
      end
    else
      respond_to do |format|
        format.html { redirect_to shopping_lists_path, alert: 'Failed update.' }
        format.json { render layout: 'error' }
      end
    end
  end

  # POST /shopping_lists
  def create
    @shopping_list = ShoppingList.create!(shopper: current_shopper)
    redirect_to shopping_list_items_path(@shopping_list), notice: 'Shopping list was successfully created.'
  end

  # DELETE /shopping_lists/1
  def destroy
    shopping_list.destroy
    respond_to do |format|
      format.html { redirect_to shopping_lists_url, notice: 'Shopping list was successfully destroyed.' }
      format.json
    end
  end

  private

  def shopping_list
    @shopping_list ||= ShoppingList.for_shopper(current_shopper).find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def shopping_list_params
    params.require(:shopping_list).permit(:title)
  end
end
