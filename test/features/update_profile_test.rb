require 'integration_helper'

class UpdateProfileTest < IntegrationTest
  test 'update shopper profile' do
    visit '/profile'
    sign_in_shopper
    assert page.has_content?('Profile')
    click_link 'Edit'
  end
end
