class Nis::Struct
  # @attr [String] meta
  # @attr [String] namespace
  # @see http://bob.nem.ninja/docs/#namespaceMetaDataPair
  class NamespaceMetaDataPair
    include Nis::Util::Assignable
    attr_accessor :meta, :namespace

    def self.build(meta:, namespace:)
      new(
        meta: NamespaceMetaData.build(meta),
        namespace: Namespace.build(namespace)
      )
    end
  end
end
