module Nis::Endpoint
  module Node::Experiences
    # @return [Nis::Struct::ExtendedNodeExperiencePair]
    # @see https://nemproject.github.io/#requesting-node-experiences
    def node_experiences
      request!(:get, '/node/experiences') do |res|
        res[:data].map { |enep| Nis::Struct::ExtendedNodeExperiencePair.build(enep) }
      end
    end
  end
end
