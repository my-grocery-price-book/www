class RegularItemsController < ApplicationController
  before_action :authenticate_shopper!
  before_action :set_regular_item, only: [:show, :edit, :update, :destroy, :delete]

  # GET /regular_items
  def index
    @regular_items = RegularItem.for_shopper(current_shopper)
  end

  # GET /regular_items/1
  def show
  end

  # GET /regular_items/new
  def new
    @regular_item = RegularItem.new
  end

  # GET /regular_items/1/delete
  def delete
  end

  # GET /regular_items/1/edit
  def edit
  end

  # POST /regular_items
  def create
    @regular_item = RegularItem.new(regular_item_params)
    @regular_item.shopper = current_shopper

    if @regular_item.save
      redirect_to regular_items_path(@regular_item), notice: 'Regular item was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /regular_items/1
  def update
    if @regular_item.update(regular_item_params)
      redirect_to @regular_item, notice: 'Regular item was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /regular_items/1
  def destroy
    @regular_item.destroy
    redirect_to regular_items_url, notice: 'Regular item was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_regular_item
      @regular_item = RegularItem.find(params[:id])
    end

    # Only allow a trusted parameter "white item" through.
    def regular_item_params
      params.require(:regular_item).permit(:name, :category)
    end
end
