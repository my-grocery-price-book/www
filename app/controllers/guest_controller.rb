class GuestController < ApplicationController
  def login
    @shopper = Shopper.create!(guest: true)
    sign_in(@shopper)
    redirect_to after_sign_in_path_for(@shopper), notice: 'Logged in as Guest'
  end
end
