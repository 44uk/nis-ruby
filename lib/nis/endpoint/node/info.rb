module Nis::Endpoint
  module Node::Info
    # @return [Nis::Struct::NodeInfo]
    # @see http://bob.nem.ninja/docs/#basic-node-information
    def node_info
      Nis::Struct::NodeInfo.build request!(:get, '/node/info')
    end
  end
end
