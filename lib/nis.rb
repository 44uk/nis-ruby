require "nis/version"
require "nis/client"
require "nis/endpoint"

class Nis
  extend Forwardable

  def_delegators('@client', 'request')

  # @param [hash] options HTTP Client connection information
  # @option options [Symbol] :url URL
  # @option options [Symbol] :scheme default http (http only)
  # @option options [Symbol] :host default 127.0.0.1
  # @option options [Symbol] :port default 7890
  # @option options [Symbol] :timeout default 5
  def initialize(options = {})
    @client = Client.new(options)
  end

  # @return [hash] NIS Heartbeat
  # @see http://bob.nem.ninja/docs/#heart-beat-request
  def heartbeat
    Nis::Endpoint::Heartbeat.new(@client).request
  end

  # @return [hash] NIS status
  # @see http://bob.nem.ninja/docs/#status-request
  def status
    Nis::Endpoint::Status.new(@client).request
  end
end
