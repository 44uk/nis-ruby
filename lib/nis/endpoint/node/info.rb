module Nis::Endpoint
  module Node::Info
    # @return [Nis::Struct::Node]
    # @see https://nemproject.github.io/#basic-node-information
    def node_info
      Nis::Struct::Node.build request!(:get, '/node/info')
    end
  end
end
