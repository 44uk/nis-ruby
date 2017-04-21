class Nis::Struct
  # @attr [String] metaData
  # @attr [String] networkId
  # @attr [String] identity
  # @see http://bob.nem.ninja/docs/#node
  class Node
    include Nis::Util::Assignable
    attr_accessor :metaData, :endpoint, :identity

    alias :meta_data  :metaData

    def self.build(attrs)
      new(attrs)
    end
  end
end
