module Nis::Endpoint
  module Node::ExtendedInfo
    # @return [Nis::Struct::Node]
    # @see http://bob.nem.ninja/docs/#extended-node-information
    def node_extended_info
      Nis::Struct::NisNodeInfo.build request!(:get, '/node/extended-info')
    end
  end
end
