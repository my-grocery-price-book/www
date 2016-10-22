# frozen_string_literal: true
class OneallController < ApplicationController
  include Devise::Controllers::Rememberable
  skip_before_action :verify_authenticity_token

  def callback
    social_profile = SocialProfile.new(params[:connection_token])
    if social_profile.authenticated?
      shopper = Shopper.find_or_create_for_social_profile(social_profile)
      sign_in shopper
      remember_me shopper
      redirect_to stored_location_for(:shopper) || book_pages_path(PriceBook.default_for_shopper(shopper)),
                  notice: 'Successfully logged in'
    else
      redirect_to new_shopper_session_path, alert: 'Log in failed'
    end
  end
end
