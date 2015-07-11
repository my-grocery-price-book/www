class ProfilesController < ApplicationController
  before_action :authenticate_shopper!

  def show
  end

  def edit
    @shopper = current_shopper
    @current_public_api_options = [
      ['Eastern Cape', 'za-ec.public-grocery-price-book-api.co.za'],
      ['Free State', 'za-fs.public-grocery-price-book-api.co.za'],
      ['Gauteng','za-gt.public-grocery-price-book-api.co.za'],
      ['KwaZulu-Natal', 'za-nl.public-grocery-price-book-api.co.za'],
      ['Limpopo', 'za-lp.public-grocery-price-book-api.co.za'],
      ['Mpumalanga', 'za-mp.public-grocery-price-book-api.co.za'],
      ['Northern Cape', 'za-nc.public-grocery-price-book-api.co.za'],
      ['North West', 'za-nw.public-grocery-price-book-api.co.za'],
      ['Western Cape', 'za-wc.public-grocery-price-book-api.co.za']
    ]
  end

  def update
    current_shopper.update(params[:shopper].permit(:current_public_api))
    redirect_to(profile_path, notice: 'Update successful')
  end
end
