# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  helper_method def current_book
    PriceBook.for_shopper(current_shopper).find_by(id: params[:book_id]) ||
    PriceBook.default_for_shopper(current_shopper)
  end

  def authenticate_shopper
    return true if shopper_signed_in?

    session[:return_to_path] = request.path
    redirect_to shopper_login_path, alert: 'please login'
    false
  end

  helper_method def current_shopper
    Shopper.find_by(id: session[:shopper_id])
  end

  helper_method def shopper_signed_in?
    current_shopper.present?
  end

  def sign_in(shopper)
    session[:shopper_id] = shopper.id
  end
end
