require File.expand_path('../boot', __FILE__)

# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"
require "csv"


if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Digitalsocial

  DATA_GRAPH = 'http://data.digitalsocial.eu/graph/organizations-and-activities'
  ONTOLOGY_GRAPH = 'http://data.digitalsocial.eu/graph/ontology/digital-social-innovation'
  MAPBOX_HOME_MAP_ID_WITH_LABELS = 'swirrl.i7nbbk9c'
  MAPBOX_HOME_MAP_ID_NO_LABELS = 'swirrl.i7nb2k3l'
  MAPBOX_SHOW_MAP_ID = 'swirrl.i5pj2lih'
  MAPBOX_PROJECT_SHOW_MAP_ID = 'swirrl.ikeb7gn0'
  MAPBOX_ORG_SHOW_MAP_ID = 'swirrl.il8el3gj'
  EU_COUNTRIES = ["Austria", "Belgium", "Bulgaria", "Cyprus", "Czech Republic",
    "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary",
    "Ireland", "Italy", "Latvia", "Lithuania", "Luxembourg", "Malta", "Netherlands",
    "Poland", "Portugal", "Romania", "Slovakia", "Slovenia", "Spain", "Sweden", "United Kingdom"
  ]



  MAPBOX_TEST_1 = 'swirrl.gh3197b8'
  MAPBOX_TEST_2 = 'swirrl.gh2ohh7p'
  MAPBOX_TEST_3 = 'swirrl.gh31khc2'
  MAPBOX_TEST_4 = 'swirrl.gh328348'
  MAPBOX_TEST_5 = 'swirrl.hlmpiefl'

  MAPBOX_TEST_6 = 'swirrl.he1k8p98'

  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    config.autoload_paths << "#{config.root}/app/models/concerns"
    config.autoload_paths << "#{config.root}/app/models/concepts"

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
   # config.active_record.whitelist_attributes = true

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
  end
  MAINTENANCE_FILE_PATH = File.join(Rails.root, 'tmp', 'maintenance.txt')
end
