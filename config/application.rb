require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ImoYoukan
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.generators do |g|
      g.template_engine(:haml)
      g.test_framework(:test_unit, fixture: true, fixture_replacement: 'fabrication')
      g.fixture_replacement(:fabrication, dir: 'test/fabricators')
    end
    config.app_generators.orm(:active_ldap)
  end
end
