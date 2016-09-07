class OneallController < ApplicationController
  skip_before_action :verify_authenticity_token

  def callback
    social_profile = SocialProfile.new(params[:connection_token])
    if social_profile.authenticated?
      shopper = Shopper.find_or_by_social_profile(social_profile)
      sign_in shopper
      redirect_to price_book_pages_path, notice: 'Successfully logged in'
    else
      redirect_to price_book_pages_path, alert: 'Log in failed'
    end
  end
end
