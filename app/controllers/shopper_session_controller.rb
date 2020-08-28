class ShopperSessionController < ApplicationController
  def create
    email = request.env['omniauth.auth']['info']['email']
    _create(email)

    redirect_to(session[:guest_register_return] || session[:return_to_path] || '/price_book_pages')
  end

  unless Rails.env.production?
    def force_login
      session[:shopper_id] = Shopper.find(params[:id]).id

      head :ok
    end
  end

  def logout
    reset_session
    redirect_to logout_url.to_s
  end

  private

  def _create(email)
    if current_shopper&.guest?
      flash['notice'] = 'You have registered successfully.'
      current_shopper.update!(email: email, guest: false)
    else
      session[:shopper_id] = Shopper.find_or_create_by!(email: email).id
    end
  end

  def logout_url
    request_params = {
      returnTo: root_url,
      client_id: ENV.fetch('AUTH0_CLIENT_ID')
    }

    URI::HTTPS.build(host: ENV.fetch('AUTH0_DOMAIN'), path: '/v2/logout', query: to_query(request_params))
  end

  def to_query(hash)
    hash.map do |key, val|
      "#{key}=#{CGI.escape(val)}" if val
    end.reject(&:nil?).join('&')
  end
end
