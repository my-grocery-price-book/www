require 'integration_helper'

class ComponentLibraryTest < ActionDispatch::IntegrationTest
  test 'List the components' do
    visit '/components'
    assert page.has_text?('Component Library')
  end
end
