class PriceCheckController < ApplicationController
  def index
  end

  def select_area
    @public_apis = RegionFinder.instance
  end

  def set_selected_area
    public_api = RegionFinder.instance.find_by_code(params[:current_public_api])
    session['current_public_api_code'] = public_api.try(:code)
    redirect_to(price_check_path, notice: 'Area Selected')
  end
end
