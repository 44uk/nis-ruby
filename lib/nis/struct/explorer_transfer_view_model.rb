class Nis::Struct
  # @attr [Nis::Struct::Transaction] tx
  # @attr [String] hash
  # @attr [String] innerHash
  # @see https://nemproject.github.io/#explorerTransferViewModel
  class ExplorerTransferViewModel
    include Nis::Util::Assignable
    attr_accessor :tx, :hash, :innerHash

    alias inner_hash innerHash
    alias inner_hash= innerHash=

    def self.build(attrs)
      attrs[:tx] = Transaction.build(attrs[:tx])
      new(attrs)
    end
  end
end
