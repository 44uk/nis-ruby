module Nis::Endpoint
  module Node::ActivePeers
    # @return [Nis::Struct::Node]
    # @see http://bob.nem.ninja/docs/#maximum-chain-height-in-the-active-neighborhood
    def node_active_peers_max_chain_height
      request!(:get, '/node/active-peers/max-chain-height') do |res|
        Nis::Struct::BlockHeight.build res
      end
    end
  end
end
