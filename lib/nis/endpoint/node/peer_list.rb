module Nis::Endpoint
  module Node::PeerList
    # @return [Nis::Struct::NodeCollection]
    # @see http://bob.nem.ninja/docs/#complete-neighborhood
    def node_peerlist_all
      Nis::Struct::NodeCollection.build request!(:get, '/node/peer-list/all')
    end

    # @return [Array <Nis::Struct::NodeInfo>]
    # @see http://bob.nem.ninja/docs/#reachable-neighborhood
    def node_peerlist_reachable
      request!(:get, '/node/peer-list/reachable') do |res|
        res[:data].map { |n| Nis::Struct::NodeInfo.build(n) }
      end
    end

    # @return [Array <Nis::Struct::NodeInfo>]
    # @see http://bob.nem.ninja/docs/#active-neighborhood
    def node_peerlist_active
      request!(:get, '/node/peer-list/active') do |res|
        res[:data].map { |n| Nis::Struct::NodeInfo.build(n) }
      end
    end
  end
end
