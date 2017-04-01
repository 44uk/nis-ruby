class Nis::Struct
  # @attr [Nis::Struct::NodeInfo] node
  # @attr [Nis::Struct::NodeInfo] nis_info
  # @see http://bob.nem.ninja/docs/#nisNodeInfo
  class NisNodeInfo
    include Nis::Util::Assignable
    attr_accessor :node, :nisInfo

    alias :nis_info :nisInfo
    alias :nis_info= :nisInfo=

    def self.build(attrs)
      new(
        node: Nis::Struct::NodeInfo.build(attrs[:node]),
        nisInfo: Nis::Struct::NodeInfo.build(attrs[:nisInfo])
      )
    end
  end
end
