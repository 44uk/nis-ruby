class Nis::Struct
  # @attr [Integer] height
  # @see http://bob.nem.ninja/docs/#blockChainScore
  class BlockHeight
    include Nis::Util::Assignable
    attr_accessor :height

    def self.build(attrs)
      new(attrs)
    end

    def to_i
      @height
    end

    def to_s
      @height.to_s
    end
  end
end
