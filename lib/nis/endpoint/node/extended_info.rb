module Nis::Endpoint
  module Node::ExtendedInfo
    # @return [Nis::Struct::Node]
    # @see https://nemproject.github.io/#extended-node-information
    def node_extended_info
      Nis::Struct::NisNodeInfo.build request!(:get, '/node/extended-info')
    end
  end
end
