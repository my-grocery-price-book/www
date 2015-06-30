class RegularListsController < ApplicationController
  before_action :set_regular_list, only: [:show, :edit, :update, :destroy, :delete]

  # GET /regular_lists
  def index
    @regular_lists = RegularList.all
  end

  # GET /regular_lists/1
  def show
  end

  # GET /regular_lists/new
  def new
    @regular_list = RegularList.new
  end

  # GET /regular_lists/1/delete
  def delete
  end

  # GET /regular_lists/1/edit
  def edit
  end

  # POST /regular_lists
  def create
    @regular_list = RegularList.new(regular_list_params)

    if @regular_list.save
      redirect_to @regular_list, notice: 'Regular item was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /regular_lists/1
  def update
    if @regular_list.update(regular_list_params)
      redirect_to @regular_list, notice: 'Regular item was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /regular_lists/1
  def destroy
    @regular_list.destroy
    redirect_to regular_lists_url, notice: 'Regular item was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_regular_list
      @regular_list = RegularList.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def regular_list_params
      params.require(:regular_list).permit(:name, :category)
    end
end
