class Nis::Struct
  # @attr [String] score
  # @see http://bob.nem.ninja/docs/#blockChainScore
  class BlockScore
    include Nis::Util::Assignable
    attr_accessor :score

    def self.build(attrs)
      new(attrs)
    end

    # @return [String]
    def to_s
      @score
    end
  end
end
