require File.expand_path('../boot', __FILE__)

require 'csv'
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Jxtime
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    config.assets.paths << Rails.root.join('vendor ', 'assets ', 'bower_components')

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    I18n.enforce_available_locales = false

    config.generators do |g|
      g.test_framework :rspec
    end

    ActiveSupport.on_load(:active_model_serializers) do
      # Disable root for all serializers (except ArraySerializer)
      ActiveModel::Serializer.root = false
    end
  end
end

