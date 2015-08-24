class PurchaseItemsController < ApplicationController
  before_action :authenticate_shopper!
  before_action :set_purchase
  before_action :set_purchase_item, only: [:show, :edit, :update, :delete]

  # POST /purchase_items
  def create
    @purchase.create_item!
    redirect_to edit_purchase_path(@purchase), notice: 'Purchase item was successfully added.'
  end

  # PATCH/PUT /purchase_items/1
  def update
    if @purchase.update_item(@purchase_item, purchase_item_params)
      PriceBookPage.update_product_for_shopper!(current_shopper, purchase_item_params)
      redirect_to edit_purchase_path(@purchase), notice: 'Purchase item was successfully updated.'
    else
      redirect_to edit_purchase_path(@purchase), alert: 'Purchase item failed update.'
    end
  end

  # DELETE /purchase_items/1
  def destroy
    @purchase.destroy_item_by_id(params[:id])
    redirect_to edit_purchase_path(@purchase), notice: 'Purchase item was successfully deleted.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_purchase
    @purchase = Purchase.find_for_shopper(current_shopper, params[:purchase_id])
  end

  def set_purchase_item
    @purchase_item = @purchase.find_item(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def purchase_item_params
    params.require(:purchase_item).permit(
      :purchase_id, :product_brand_name, :regular_name, :category, :package_size, :package_unit, :quantity, :total_price
    )
  end
end
