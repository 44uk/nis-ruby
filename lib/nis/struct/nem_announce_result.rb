class Nis::Struct
  # @attr [String] type
  # @attr [String] code
  # @attr [String] message
  # @attr [String] transactionHash
  # @attr [String] innerTransactionHash
  # @see https://nemproject.github.io/#nemAnnounceResult
  class NemAnnounceResult
    include Nis::Util::Assignable
    attr_accessor :type, :code, :message, :transactionHash, :innerTransactionHash

    alias :transaction_hash :transactionHash
    alias :inner_transaction_hash :innerTransactionHash

    def self.build(attrs)
      attrs[:transactionHash] = Nis::Unit::Hash.new(attrs[:transactionHash][:data])
      attrs[:innerTransactionHash] = Nis::Unit::Hash.new(attrs[:innerTransactionHash][:data])
      new(attrs)
    end
  end
end
