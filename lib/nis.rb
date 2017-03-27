require "nis/version"
require "nis/util"
require "nis/client"
require "nis/endpoint"
require "nis/struct"
require "nis/unit"

class Nis
  extend Forwardable

  def_delegators :@client, :request

  # @param [hash] options HTTP Client connection information
  # @option options [Symbol] :url URL
  # @option options [Symbol] :scheme default http (http only)
  # @option options [Symbol] :host default 127.0.0.1
  # @option options [Symbol] :port default 7890
  # @option options [Symbol] :timeout default 5
  def initialize(options = {})
    @client = Client.new(options)
  end

  include Nis::Endpoint::Heartbeat
  include Nis::Endpoint::Status
end
