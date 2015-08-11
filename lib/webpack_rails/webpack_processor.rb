require 'securerandom'
require 'open-uri'

module WebpackRails
  module WebpackProcessor
    def self.server_pid=(val)
      @pid = val
    end

    def self.server_pid
      @pid
    end

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
      WebpackRails::WebpackProcessor::ensure_server_started()

      filename = Pathname(input[:filename])
      module_name = filename.relative_path_from(Rails.root + "app/assets/javascripts")

      open("http://localhost:3001/#{module_name}") do |io|
        io.read
      end
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

    def self.ensure_server_started
      if server_pid
        return
      end

      self.server_pid = Process.spawn("node #{Rails.root+"server.js"}");

      count = 0
      begin
        open("http://localhost:3001/")
      rescue Errno::ECONNREFUSED
        count += 1

        if count > 100
          return
        end

        sleep 0.5
        retry
      rescue OpenURI::HTTPError
        return
      end
    end
  end
end

at_exit {
  pid = WebpackRails::WebpackProcessor.server_pid
  if pid
    begin
      Process.kill "INT", pid
      Process.waitpid pid
    rescue Errno::ECHILD
    end
  end
}
