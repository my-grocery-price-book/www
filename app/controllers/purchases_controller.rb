class PurchasesController < ApplicationController
  before_action :authenticate_shopper!
  before_action :set_purchase, only: [:show, :edit, :update, :delete, :destroy]

  # GET /purchases
  def index
    @purchases = Purchase.for_shopper(current_shopper)
  end

  # GET /purchases/1
  def show
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
  end

  # GET /purchases/1/edit
  def edit
  end

  # POST /purchases
  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.shopper = current_shopper

    if @purchase.save
      redirect_to purchase_items_path(@purchase), notice: 'Purchase was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /purchases/1
  def update
    if @purchase.update(purchase_params)
      redirect_to @purchase, notice: 'Purchase was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /purchases/1
  def destroy
    @purchase.destroy
    redirect_to purchases_url, notice: 'Purchase was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.for_shopper(current_shopper).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def purchase_params
      params.require(:purchase).permit(:purchased_on, :store, :location)
    end
end
