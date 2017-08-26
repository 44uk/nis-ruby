class Nis::Struct
  # @attr [Integer] timeStamp
  # @attr [String] signature
  # @attr [String] prevBlockHash
  # @attr [Integer] type
  # @attr [Array <Nis::Struct::transaction>] transactions
  # @attr [Integer] version
  # @attr [String] signer
  # @attr [Integer] height
  # @see https://nemproject.github.io/#block
  class Block
    include Nis::Util::Assignable
    attr_accessor :timeStamp, :signature, :prevBlockHash, :type, :transactions, :version, :signer, :height

    alias :timestamp :timeStamp
    alias :timestamp= :timeStamp=
    alias :prev_block_hash :prevBlockHash
    alias :prev_block_hash= :prevBlockHash=

    def self.build(attrs)
      attrs[:transactions] = attrs[:transactions].map { |tx| Transaction.build(tx) }
      new(attrs)
    end
  end
end
