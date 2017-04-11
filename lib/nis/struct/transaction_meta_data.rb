class Nis::Struct
  # @attr [Integer] height
  # @attr [Integer] id
  # @attr [Hash] hash
  # @see http://bob.nem.ninja/docs/#transactionMetaData
  class TransactionMetaData
    include Nis::Util::Assignable
    attr_accessor :height, :id, :hash

    def self.build(attrs)
      new(attrs)
    end
  end
end
