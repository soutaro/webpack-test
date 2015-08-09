require "yaml"

module WebpackRails
  class Railtie < Rails::Engine
    config.webpack_rails = ActiveSupport::OrderedOptions.new

    initializer :setup_webpack do |app|
      app.assets.register_postprocessor "application/javascript", WebpackProcessor
    end
  end
end
