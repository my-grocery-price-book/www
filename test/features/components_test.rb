require 'integration_helper'

class ComponentLibraryTest < IntegrationTest
  test 'List the components' do
    visit '/components'
    assert page.has_text?('Component Library')
  end
end
