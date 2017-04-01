class Nis::Struct
  # @attr [Array <Nis::Struct::Transaction>] txes
  # @attr [String] block
  # @attr [String] hash
  # @see http://bob.nem.ninja/docs/#explorerBlockViewModel
  class ExplorerBlockViewModel
    include Nis::Util::Assignable
    attr_accessor :txes, :block, :hash

    def self.build(attrs)
      attrs[:txes] = attrs[:txes].map { |t| Transaction.new(t) }
      new(attrs)
    end
  end
end
