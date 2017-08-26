class Nis::Struct
  # @attr [Integer] height
  # @attr [Integer] id
  # @attr [Hash] hash
  # @see https://nemproject.github.io/#transactionMetaData
  class TransactionMetaData
    include Nis::Util::Assignable
    attr_accessor :height, :id, :hash

    def self.build(attrs)
      new(attrs)
    end
  end
end
