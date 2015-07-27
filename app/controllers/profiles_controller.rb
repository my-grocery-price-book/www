class ProfilesController < ApplicationController
  before_action :authenticate_shopper!

  def show
  end

  def edit
    @shopper = current_shopper
    @public_apis = PublicApi.all
  end

  def update
    current_shopper.update(params[:shopper].permit(:current_public_api))
    redirect_to(profile_path, notice: 'Update successful')
  end
end
