class Nis::Struct
  # @attr [String] metaData
  # @attr [String] features
  # @attr [String] networkId
  # @attr [String] application
  # @attr [String] version
  # @attr [String] platform
  # @attr [String] endpoint
  # @attr [String] protocol
  # @attr [String] port
  # @attr [String] host
  # @attr [String] identity
  # @attr [String] name
  # @attr [String] publicKey
  # @see http://bob.nem.ninja/docs/#nodeInfo
  class NodeInfo
    include Nis::Util::Assignable
    attr_accessor :metaData, :features, :networkId, :application, :version, :platform, :endpoint, :protocol, :port, :host, :identity, :name, :publicKey

    alias :meta_data :metaData
    alias :network_id :networkId
    alias :public_key :publicKey

    def self.build(attrs)
      new(attrs)
    end
  end
end
