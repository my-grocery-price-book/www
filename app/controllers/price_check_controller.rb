class PriceCheckController < ApplicationController
  def index
    unless current_public_api_selected?
      redirect_to_path = select_area_path
      redirect_to_path = edit_profile_path if shopper_signed_in?
      redirect_to(redirect_to_path, notice: 'Select Area')
    end
  end

  def select_area
    @public_apis = PublicApi.all
  end

  def set_selected_area
    public_api = PublicApi.find_by_code(params[:current_public_api])
    session['current_public_api_code'] = public_api.try(:code)
    redirect_to(price_check_path, notice: 'Area Selected')
  end
end
