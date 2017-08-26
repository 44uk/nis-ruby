module Nis::Endpoint
  module Node::Boot
    # @param boot_node_request [Nis::Struct::BootNodeRequest]
    # @return [nil]
    # @see https://nemproject.github.io/#booting-the-local-node
    def node_boot(boot_node_request:)
      request!(:post, '/node/boot', boot_node_request)
    end
  end
end
