# frozen_string_literal: true
class ProfilesController < ApplicationController
  before_action :authenticate_shopper!

  def show
  end

  def edit
    @shopper = current_shopper
  end

  def update
    current_shopper.update(params[:shopper].permit(:name)) if params.key?(:shopper)
    redirect_to(profile_path, notice: 'Update successful')
  end
end
