module Nis::Endpoint
  module Namespace
    # @param [String] namespace
    # @return [Nis::Struct::Namespace]
    # @see http://bob.nem.ninja/docs/#retrieving-a-specific-namespace
    def namespace(namespace:)
      Nis::Struct::Namespace.build request!(:get, '/namespace', namespace: namespace)
    end
  end
end
