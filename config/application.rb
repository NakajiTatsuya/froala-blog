require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dragonarrow
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.time_zone = "Tokyo"
    config.active_record.default_timezone = :local
    config.assets.initialize_on_precompile = false
    config.assets.enabled = true
    config.enable_dependency_loading = true
    config.autoload_paths += %W(#{config.root}/lib)
    # rack-attackを有効化
    config.middleware.use Rack::Attack

  end
end
