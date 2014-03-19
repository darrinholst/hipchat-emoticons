require File.expand_path('../boot', __FILE__)

require "active_model/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module HipchatEmoticons
  class Application < Rails::Application
    config.google_analytics = false
  end
end
