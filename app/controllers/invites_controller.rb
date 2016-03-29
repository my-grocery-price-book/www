# == Schema Information
#
# Table name: invites
#
#  id            :integer          not null, primary key
#  price_book_id :integer
#  name          :string
#  email         :string
#  status        :string           default("sent"), not null
#  token         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class InvitesController < ApplicationController
  before_action :authenticate_shopper!

  def new
    @invite = Invite.new
    @invite.price_book = price_book
  end

  def create
    @invite = Invite.new(invite_params)
    @invite.price_book = price_book
    if @invite.save
      ShopperMailer.invite(@invite).deliver_later
      redirect_to price_book_pages_path, notice: 'Invite successfully sent'
    else
      render :new
    end
  end

  private

  def price_book
    @price_book ||= PriceBook.find_for_shopper(current_shopper, params[:price_book_id])
  end

  # Only allow a trusted parameter "white item" through.
  def invite_params
    params.require(:invite).permit(:name, :email)
  end

  public

  def show
    redirect_to price_book_pages_path, alert: 'Token expired' if invite.token_invalid?
  end

  def accept
    if invite.token_valid?
      invite.accept_by(current_shopper)
      redirect_to price_book_pages_path, notice: 'Invite accepted'
    else
      redirect_to price_book_pages_path, alert: 'Token expired'
    end
  end

  def reject
    if invite.token_valid?
      invite.reject
      redirect_to price_book_pages_path, notice: 'Invite rejected'
    else
      redirect_to price_book_pages_path, alert: 'Token expired'
    end
  end

  def invite
    @invite ||= Invite.find_by_token(params[:id])
  end
end
