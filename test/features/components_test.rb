require 'features_helper'

class ComponentLibraryTest < FeatureTest
  test 'List the components' do
    @guest = ShopperPersonaSession.new
    @guest.visit '/components'
    assert @guest.has_text?('Component Library')
  end
end
