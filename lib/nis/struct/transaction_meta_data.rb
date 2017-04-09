class Nis::Struct
  # @attr []
  # @attr []
  # @attr []
  # @attr []
  # @attr []
  # @attr []
  # @see http://bob.nem.ninja/docs/#transactionMetaData
  class TransactionMetaData
    include Nis::Util::Assignable
    attr_accessor :height, :id, :hash

    def self.build(attrs)
      new(attrs)
    end
  end
end
