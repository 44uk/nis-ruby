module Nis::Endpoint
  module Node::Experiences
    # @return [Nis::Struct::ExtendedNodeExperiencePair]
    # @see http://bob.nem.ninja/docs/#requesting-node-experiences
    def node_experiences
      request!(:get, '/node/experiences') do |res|
        res[:data].map { |enep| Nis::Struct::ExtendedNodeExperiencePair.build(enep) }
      end
    end
  end
end
