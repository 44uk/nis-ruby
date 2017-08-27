require 'faraday'
require 'faraday_middleware'
require 'json'
require 'uri'
require 'time'

# @attr [Hash] options connection options
class Nis::Client
  LOCAL_ONLY_PATHES = [
    '/account/generate',
    '/local/account/transfers/incoming',
    '/local/account/transfers/outgoing',
    '/local/account/transfers/all',
    '/node/boot',
    '/transaction/prepare-announce',
    '/shutdown'
  ]

  # @param [Nis::Connection] connection information
  def initialize(connection)
    @connection = connection
  end

  # @param [Symbol] method HTTP Method(GET or POST)
  # @param [String] path API Path
  # @param [Hash] params API Parameters
  # @return [Hash] Hash converted API Response
  def request(method, path, params = {})
    if agent.remote? && local_only?(path)
      raise Nis::Error, "The request (#{method} #{path}) is only permitted to local NIS."
    end
    if params.is_a?(Hash) && !params.empty?
      params.reject! { |_, value| value.nil? }
    end
    res = agent.send(method, path, params)
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

  def agent
    @agent ||= Faraday.new(url: @connection.url) do |f|
      f.options[:timeout] = @connection.timeout
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

  module Local
    def local?
      host == '127.0.0.1' || host == 'localhost'
    end

    def remote?
      !local?
    end
  end
end
