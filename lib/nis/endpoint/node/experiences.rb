module Nis::Endpoint
  module Node::Experiences
    # @return [Nis::Struct::ExtendedNodeExperiencePair]
    # @see http://bob.nem.ninja/docs/#requesting-node-experiences
    def node_experiences
      Nis::Struct::ExtendedNodeExperiencePair.build request!(:get, '/node/experiences')
    end
  end
end
