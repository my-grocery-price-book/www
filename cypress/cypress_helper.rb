# This is loaded once before the first command is executed

require 'database_cleaner'
require 'factory_girl_rails'
require 'cypress_on_rails/smart_factory_wrapper'

CypressOnRails::SmartFactoryWrapper.configure(
  always_reload: !Rails.configuration.cache_classes,
  factory: FactoryGirl,
  files: [
    Rails.root.join('spec', 'factories.rb'),
    Rails.root.join('spec', 'factories', '**', '*.rb')
  ]
)
