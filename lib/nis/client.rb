require 'faraday'
require 'json'
require 'uri'

# @attr [Hash] options connection options
class Nis::Client
  DEFAULTS = {
    url:     -> {ENV['NIS_URL']},
    scheme:  'http',
    host:    '127.0.0.1',
    port:    7890,
    timeout: 5
  }

  attr :options

  # @param [hash] options HTTP Client connection information
  # @option options [Symbol] :url URL
  # @option options [Symbol] :scheme default http (http only)
  # @option options [Symbol] :host default 127.0.0.1
  # @option options [Symbol] :port default 7890
  # @option options [Symbol] :timeout default 5
  def initialize(options = {})
    @options = parse_options(options)
  end

  # @param [Symbol] method HTTP Method(GET or POST)
  # @param [String] path API Path
  # @param [Hash] params API Parameters
  # @return [Hash] Hash converted API Response
  def request(method, path, params = nil, &block)
    body = connection.send(method, path, params).body
    hash = parse_body(body) unless body.size == 0
    block_given? ? yield(hash) : hash
  end

  private

  def connection
    @connection ||= Faraday.new(url: @options[:url]) do |f|
      f.options[:timeout] = @options[:timeout]
      f.request :url_encoded
      f.adapter Faraday.default_adapter
      # f.response :logger do | logger |
      #   logger.filter(/(privateKey=)(\w+)/,'\1[FILTERED]')
      # end
    end
  end

  def parse_body(body)
    JSON.parse(body, symbolize_names: true)
  end

  def parse_options(options = {})
    defaults = DEFAULTS.dup
    options  = options.dup

    defaults[:url] = defaults[:url].call if defaults[:url].respond_to?(:call)

    defaults.keys.each do |key|
      options[key] = options[key.to_s] if options.has_key?(key.to_s)
    end

    url = options[:url] || defaults[:url]

    if url
      uri = URI(url)
      if uri.scheme == "http"
        defaults[:scheme] = uri.scheme
        defaults[:host]   = uri.host
        defaults[:port]   = uri.port
      else
        raise ArgumentError, "invalid URI scheme '#{uri.scheme}'"
      end
    end

    defaults.keys.each do |key|
      options[key] = defaults[key] if options[key].nil?
    end

    options[:url] = URI::Generic.build(
      scheme: options[:scheme],
      host:   options[:host],
      port:   options[:port]
    ).to_s

    options
  end
end
