module Nis::Endpoint
  module Namespace
    # @param [String] namespace
    # @return [Nis::Struct::Namespace]
    # @see https://nemproject.github.io/#retrieving-a-specific-namespace
    def namespace(namespace:)
      Nis::Struct::Namespace.build request!(:get, '/namespace', namespace: namespace)
    end
  end
end
