class Nis::Struct
  # @attr [String] metaData
  # @attr [String] application
  # @attr [String] endpoint
  # @attr [String] protocol
  # @attr [String] port
  # @attr [String] host
  # @attr [String] identity
  # @attr [String] private_key
  # @attr [String] name
  # @see http://bob.nem.ninja/docs/#bootNodeRequest
  class BootNodeRequest
    include Nis::Util::Assignable
    attr_accessor :metaData, :application, :endpoint, :protocol, :port, :host, :identity, :private_key, :name

    alias metadata metaData
    alias metadata= metaData=

    def self.build(attrs)
      new(attrs)
    end
  end
end
