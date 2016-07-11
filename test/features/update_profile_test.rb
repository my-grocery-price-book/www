require 'features_helper'

class UpdateProfileTest < FeatureTest
  test 'update shopper profile' do
    @shopper = ShopperPersonaSession.new(email: 'shopper@example.com')
    @shopper.sign_up
    @shopper.visit '/profile'
    assert @shopper.has_content?('Profile')
    @shopper.click_link 'Edit'
  end
end
