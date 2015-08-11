require 'securerandom'

module WebpackRails
  module WebpackProcessor
    def self.cache_key
      "webpack" + SecureRandom.hex(3)
    end

    def self.call(input)
      if needs_webpack?(input)
        run_webpack(input)
      else
        input[:data]
      end
    end

    def self.run_webpack(input)
      src = Rails.root + "tmp" + SecureRandom.hex(8)
      dest = Rails.root + "tmp" + SecureRandom.hex(8)

      src.write input[:data]
      system "webpack --config #{Rails.root+"webpack.js"} -d #{src} #{dest}"
      src.unlink
      dest.read.tap do dest.unlink end
    end

    def self.needs_webpack?(input)
      filename = input[:filename]
      Rails.configuration.assets.precompile.any? {|test|
        case test
        when Regexp
          test =~ filename
        when Proc
          test[input[:uri], filename]
        end
      }
    end
  end
end
