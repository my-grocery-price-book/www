class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_public_api

  # before_action :slow_down_if_xhr
  protected

  # def slow_down_if_xhr
  #   sleep(3) if request.xhr?
  # end
end
