require 'logger'

class Nis
  module Configuration
    # Logger for {#debug}, default is `Nis::Logger.new(STDOUT)`
    # @return [Logger]
    attr_accessor :logger

    def self.extended(base)
      base.logger = Logger.new($stdout).tap { |logger| logger.level = Logger::INFO }
    end

    # @yield [self]
    # @example
    #   Nis.configure do |conf|
    #     conf.logger = Logger.new('path/to/nis-ruby.log')
    #     conf.logger.level = Logger::DEBUG
    #   end
    def configure
      yield self
    end
  end
end
