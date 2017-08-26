class Nis::Struct
  # @attr [Nis::Struct::NodeInfo] node
  # @attr [Nis::Struct::NodeInfo] nisInfo
  # @see https://nemproject.github.io/#nisNodeInfo
  class NisNodeInfo
    include Nis::Util::Assignable
    attr_accessor :node, :nisInfo

    alias :nis_info :nisInfo
    alias :nis_info= :nisInfo=

    def self.build(attrs)
      new(
        node: Nis::Struct::Node.build(attrs[:node]),
        nisInfo: Nis::Struct::ApplicationMetaData.build(attrs[:nisInfo])
      )
    end
  end
end
