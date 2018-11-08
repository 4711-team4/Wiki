require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module Wiki
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    config.middleware.use Rack::Attack
    
    # Demo Banned IP List for testing purposes. Once updated here, make changes in config/initializers/rack_attack.rb
    # config.demoBannedIPList= ['127.0.0.1']
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
