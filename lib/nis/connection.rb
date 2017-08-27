class Nis
  class Connection
    attr_reader :url, :scheme, :host, :port, :timeout, :priority

    DEFAULTS = {
      url: -> { ENV['NIS_URL'] },
      scheme: 'http',
      host: '127.0.0.1',
      port: 7890,
      timeout: 5,
      priority: 0
    }.freeze

    # @param [hash] options HTTP Client connection information
    # @option options [Symbol] :url URL
    # @option options [Symbol] :scheme default http (http only)
    # @option options [Symbol] :host default 127.0.0.1
    # @option options [Symbol] :port default 7890
    # @option options [Symbol] :timeout default 5
    def initialize(options = {})
      @options = parse_options(options)
      @options.each do |k, v|
        instance_variable_set("@#{k}", v) if respond_to?(k.to_s)
        # send("#{k.to_s}=", v) if respond_to?("#{k.to_s}")
        # require 'pry'; binding.pry
      end
    end

    private

    def parse_options(options)
      defaults = DEFAULTS.dup
      options  = options.dup

      defaults[:url] = defaults[:url].call if defaults[:url].respond_to?(:call)

      defaults.keys.each do |key|
        options[key] = options[key.to_s] if options.key?(key.to_s)
      end

      url = options[:url] || defaults[:url]

      if url
        uri = URI(url)
        if uri.scheme == 'http'
          defaults[:scheme] = uri.scheme
          defaults[:host] = uri.host
          defaults[:port] = uri.port
        else
          raise ArgumentError, "invalid URI scheme '#{uri.scheme}'"
        end
      end

      defaults.keys.each do |key|
        options[key] = defaults[key] if options[key].nil?
      end

      options[:url] = URI::Generic.build(
        scheme: options[:scheme],
        host: options[:host],
        port: options[:port]
      ).to_s

      options
    end
  end
end
