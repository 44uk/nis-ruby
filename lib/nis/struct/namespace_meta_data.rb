class Nis::Struct
  # @attr [Integer] id
  # @see http://bob.nem.ninja/docs/#namespaceMetaData
  class NamespaceMetaData
    include Nis::Util::Assignable
    attr_accessor :id

    def self.build(attrs)
      new(attrs)
    end
  end
end
