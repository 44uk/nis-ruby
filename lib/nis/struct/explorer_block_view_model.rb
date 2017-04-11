class Nis::Struct
  # @attr [Array <Nis::Struct::ExplorerTransferViewModel>] txes
  # @attr [Nis::Struct::Block] block
  # @attr [String] hash
  # @attr [String] difficulty
  # @see http://bob.nem.ninja/docs/#explorerBlockViewModel
  class ExplorerBlockViewModel
    include Nis::Util::Assignable
    attr_accessor :txes, :block, :hash, :difficulty

    def self.build(attrs)
      attrs[:txes] = attrs[:txes].map { |tx| ExplorerTransferViewModel.build(tx) }
      attrs[:block] = Block.build(attrs[:block])
      new(attrs)
    end
  end
end
