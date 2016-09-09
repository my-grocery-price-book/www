# frozen_string_literal: true
class DeviseCustomFailure < Devise::FailureApp
  def redirect_url
    to_shopper_registration || super
  end

  private

  def to_shopper_registration
    return nil unless warden_options[:scope] == :shopper

    controller_params = request.env['action_dispatch.request.path_parameters']
    return nil unless controller_params[:controller] == 'invites'

    invite = Invite.find_by(token: controller_params[:id])
    return nil unless invite.try(:no_shopper_exists?)

    new_shopper_registration_path(name: invite.name, email: invite.email)
  end

  public

  def respond
    http_auth? ? http_auth : redirect
  end
end
