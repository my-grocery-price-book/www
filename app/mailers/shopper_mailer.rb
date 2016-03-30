class ShopperMailer < ApplicationMailer
  # @param [Invite] invite
  def invite(invite)
    @invite = invite
    mail to: invite.email
  end
end
