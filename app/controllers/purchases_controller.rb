class PurchasesController < ApplicationController
  before_action :authenticate_shopper!
  before_action :check_public_api_is_selected, only: [:complete]
  before_action :set_purchase, only: [:show, :edit, :update, :delete, :destroy, :complete]

  # GET /purchases
  def index
    @purchases = Purchase.for_shopper(current_shopper)
  end

  # GET /purchases/1/edit
  def edit
    @items = @purchase.items.order('id DESC')
  end

  # POST /purchases
  def create
    @purchase = Purchase.create_for_shopper!(current_shopper)
    redirect_to edit_purchase_path(@purchase), notice: 'Purchase was successfully created.'
  end

  # PATCH/PUT /purchases/1
  def update
    if @purchase.update(purchase_params)
      redirect_to edit_purchase_path(@purchase), notice: 'Purchase was successfully updated.'
    else
      render :edit
    end
  end

  # PATCH/PUT /purchase_items/1/complete
  def complete
    @purchase.mark_as_completed(
      api_root: current_public_api.url_root,
      api_region_code: current_public_api.code,
      api_key: ShopperApiKey.api_key(shopper: current_shopper,
                                     api_root: current_public_api.url_root),
      current_time: Time.current
    )
    redirect_to edit_purchase_path(@purchase), notice: 'Sending prices to price book'
  end

  # DELETE /purchases/1
  def destroy
    @purchase.destroy
    redirect_to purchases_url, notice: 'Purchase was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_purchase
    @purchase = Purchase.find_for_shopper(current_shopper, params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def purchase_params
    params.require(:purchase).permit(:purchased_on, :store, :location)
  end
end
