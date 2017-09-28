require 'faraday'
require 'faraday_middleware'
require 'json'
require 'uri'
require 'time'

# @attr [Hash] options connection options
class Nis::Client
  DEFAULTS = {
    url:     -> { ENV['NIS_URL'] },
    scheme:  'http',
    host:    '127.0.0.1',
    port:    7890,
    timeout: 5
  }.freeze

  LOCAL_ONLY_PATHES = [
    '/account/generate',
    '/local/account/transfers/incoming',
    '/local/account/transfers/outgoing',
    '/local/account/transfers/all',
    '/node/boot',
    '/transaction/prepare-announce',
    '/shutdown'
  ]

  attr_reader :options

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
  def request(method, path, params = {})
    log(method, path, params)
    if connection.remote? && local_only?(path)
      raise Nis::Error, "The request (#{method} #{path}) is only permitted to local NIS."
    end
    if params.is_a?(Hash) && !params.empty?
      params.reject! { |_, value| value.nil? }
    end
    res = connection.send(method, path, params)
    body = res.body
    hash = parse_body(body) unless body.empty?
    block_given? ? yield(hash) : hash
  end

  # @param [Symbol] method HTTP Method(GET or POST)
  # @param [String] path API Path
  # @param [Hash] params API Parameters
  # @return [Hash] Hash converted API Response
  # @raise [Nis::Error] NIS error
  def request!(method, path, params = {})
    hash = request(method, path, params)
    raise Nis::Util.error_handling(hash) if hash && hash.key?(:error)
    block_given? ? yield(hash) : hash
  end

  private

  def local_only?(path)
    LOCAL_ONLY_PATHES.include?(path)
  end

  def connection
    @connection ||= Faraday.new(url: @options[:url]) do |f|
      f.options[:timeout] = @options[:timeout]
      f.request :json
      # f.response :logger do | logger |
      #   logger.filter(/(privateKey=)(\w+)/,'\1[FILTERED]')
      # end
      f.adapter Faraday.default_adapter
    end.tap { |c| c.extend(Local) }
  end

  def parse_body(body)
    JSON.parse(body, symbolize_names: true)
  end

  def parse_options(options = {})
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

  def log(method, path, params)
    Nis.logger.debug "host:%s\tmethod:%s\tpath:%s\tparams:%s" % [
      connection.url_prefix,
      method,
      path,
      params.to_hash
    ]
  end

  module Local
    def local?
      host == '127.0.0.1' || host == 'localhost'
    end

    def remote?
      !local?
    end
  end
end
