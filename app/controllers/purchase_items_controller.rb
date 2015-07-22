class PurchaseItemsController < ApplicationController
  before_action :authenticate_shopper!
  before_action :set_purchase
  before_action :set_purchase_item, only: [:show, :edit, :update, :delete]

  # GET /purchase_items
  def index
    @purchase_items = @purchase.items
  end

  # GET /purchase_items/1
  def show
  end

  # GET /purchase_items/new
  def new
    @purchase_item = @purchase.new_item
  end

  # GET /purchase_items/1/edit
  def edit
  end

  # POST /purchase_items
  def create
    @purchase_item = @purchase.new_item(purchase_item_params)

    if @purchase.save_item(@purchase_item)
      RegularItem.update_product_for_shopper!(current_shopper,purchase_item_params)
      redirect_to purchase_items_path(@purchase), notice: 'Purchase item was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /purchase_items/1
  def update
    if @purchase.update_item(@purchase_item,purchase_item_params)
      redirect_to purchase_item_path(@purchase,@purchase_item), notice: 'Purchase item was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /purchase_items/1
  def destroy
    @purchase.destroy_item_by_id(params[:id])
    redirect_to purchase_items_path(@purchase), notice: 'Purchase item was successfully destroyed.'
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
      params.require(:purchase_item).permit(:purchase_id, :product_brand_name, :regular_name, :category, :package_size, :package_unit, :quanity, :total_price)
    end
end
