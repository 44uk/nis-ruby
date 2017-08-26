class Nis::Struct
  # @attr [String] metaData
  # @attr [String] networkId
  # @attr [String] identity
  # @see https://nemproject.github.io/#node
  class Node
    include Nis::Util::Assignable
    attr_accessor :metaData, :endpoint, :identity

    alias :meta_data  :metaData

    def self.build(attrs)
      new(attrs)
    end
  end
end
