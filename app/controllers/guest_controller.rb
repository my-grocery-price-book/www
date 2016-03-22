class GuestController < ApplicationController
  def login
    @shopper = Shopper.create!(guest: true)
    @shopper.remember_me!
    sign_in(@shopper)
    redirect_to after_sign_in_path_for(@shopper), notice: 'Logged in as Guest'
  end

  def register
    @shopper = current_shopper
    session[:guest_register_return] = request.referrer
  end

  def do_register
    @shopper = current_shopper
    if @shopper.update(shopper_params)
      sign_out(@shopper)
      @shopper.send_confirmation_instructions
      @shopper.update_attribute(:guest, false)
      sign_in(@shopper)
      redirect_to session[:guest_register_return] || root_path, notice: 'You have registered successfully.'
    else
      render :register
    end
  end

  private

  # Only allow a trusted parameter "white item" through.
  def shopper_params
    params.require(:shopper).permit(:email, :password, :password_confirmation)
  end
end
