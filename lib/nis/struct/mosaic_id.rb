class Nis::Struct
  # @attr [String] namespaceId
  # @attr [String] name
  # @see http://bob.nem.ninja/docs/#mosaicId
  class MosaicId
    include Nis::Util::Assignable
    attr_accessor :namespaceId, :name

    alias :namespace_id :namespaceId
    alias :namespace_id= :namespaceId=

    def self.build(attrs)
      new(attrs)
    end
  end
end
