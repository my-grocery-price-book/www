# frozen_string_literal: true
require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Project
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.active_record.schema_format = :sql

    config.generators do |generator|
      generator.template_engine :erb
      generator.orm :active_record, primary_key_type: :uuid
    end

    Rails.application.config.assets.precompile +=
      ['shims.js', 'components.js', 'vendor.js', 'vendor.css']
  end
end
