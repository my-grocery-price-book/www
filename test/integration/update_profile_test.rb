require 'integration_helper'

class UpdateProfileTest < ActionDispatch::IntegrationTest
  test 'update shopper profile' do
    visit '/profile'
    sign_in_shopper
    assert page.has_content?('Profile')
    click_link 'Edit'

    select 'North West', from: 'Current public api'
    click_button 'Update'
    assert page.has_css?('.notice', text: 'Update successful')
    assert page.has_content?('North West')
  end
end
