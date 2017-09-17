require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Potracheno
  class Application < Rails::Application
    config.load_defaults 5.1
    config.autoload_paths << "#{Rails.root}/lib"
    config.autoload_paths << "#{Rails.root}/app/interactors"
    config.autoload_paths << "#{Rails.root}/app/queries"
    config.i18n.default_locale = :ru
  end
end
