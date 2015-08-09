module WebpackRails
  class WebpackProcessor < Tilt::Template
    attr_accessor :config

    def initialize(template)
      # self.config = Rails.application.config.webpack_rails
      super(template)
    end

    def prepare
    end

    def evaluate(context, locals, &block)
      1/0
    end

    private
  end
end
