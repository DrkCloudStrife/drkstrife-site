require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DrkstrifeSite
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    config.eager_load_paths << Rails.root.join("lib")
    config.eager_load_paths << Rails.root.join("app/objects")
    # config.autoload_paths += %W(#{config.root}/lib #{config.root}/app/objects)

    # Don't generate system test files.
    config.generators.system_tests = nil

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.filter_parameters += [:password]

    config.i18n.fallbacks = true

    config.server_hostname = Socket.gethostname.downcase.hash

    config.before_configuration do
      env_file = Rails.root + 'config/local_env.yml'
      YAML.load(env_file.open).each do |key, value|
        ENV[key.to_s] = value
      end if env_file.exist?
    end

  end
end
