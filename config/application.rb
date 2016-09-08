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

    config.generators do |g|
      g.template_engine :erb
      g.orm :active_record, primary_key_type: :uuid
    end

    Rails.application.config.assets.precompile +=
      ['react-server.js', 'shims.js', 'components.js', 'vendor.js', 'vendor.css']

    config.react.addons = true # defaults to false
    config.react.server_renderer_options = {
      files: ['react-server.js', 'components.js', 'shims.js'], # files to load for prerendering
      replay_console: true, # if true, console.* will be replayed client-side
    }
  end
end
