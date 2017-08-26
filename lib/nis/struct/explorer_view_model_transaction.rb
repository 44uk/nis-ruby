class Nis::Struct
  # @attr [Array <Nis::Struct::Transaction>] txes
  # @attr [String] block
  # @attr [String] hash
  # @see https://nemproject.github.io/#explorerViewModelTransaction
  class ExplorerViewModelTransaction
    include Nis::Util::Assignable
    attr_accessor :txes, :block, :hash

    def self.build(attrs)
      attrs[:txes] = attrs[:txes].map { |tx| Transaction.build(tx) }
      attrs[:block] = Block.build(attrs[:block])
      new(attrs)
    end
  end
end
